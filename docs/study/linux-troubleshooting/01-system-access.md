# 1 — System Access

"I can't reach it." The most common class of incident: a host, website, app, or login that won't
respond. The skill is checking the layers **in order** so you find *where* the path breaks.

Command sequences live in [`reference/troubleshooting.md`](../../reference/troubleshooting.md#system-access--host-or-service-unreachable);
hands-on in [`src/03-troubleshooting/01-system-access`](../../../src/03-troubleshooting/01-system-access/).

---

## The mental model: a chain from you to the app

A request crosses many layers. Any one can break the whole chain, and the symptom ("can't connect")
looks the same regardless of which. So you test the chain in order and stop at the first break:

```
your machine → network link → the host's IP → routing/gateway →
name resolution (DNS) → the listening port → the service → its config → the app
```

Working *outward to inward* (or low layer to high) means each test rules out everything before it.

## Host unreachable

**Why it happens.** The host is powered off, has no/blocked network, has the wrong IP, has no route
to it, or a name doesn't resolve to the right address.

**How to diagnose (in order).**

1. `ping <ip>` — does the host answer at the raw IP level? If yes, the network and host are up; the
   problem is higher (DNS, port, service).
2. `ping <hostname>` — works by IP but **not** by name? That isolates it to **name resolution**.
3. `ip addr show` — does the host even have the IP you expect?
4. `ip route show` — is there a default route / gateway out?
5. Only after all that: suspect physical/VM state (cable, NIC, the VM is paused/off).

**The key inference:** *IP works but name doesn't = DNS.* That one split saves enormous time.

## Name resolution (DNS) failures

**Why it happens.** Wrong or unreachable DNS server, a bad `/etc/hosts` entry overriding the real
one, or resolution order misconfigured.

**How to diagnose.** `getent hosts <name>` shows what the system actually resolves (it respects the
real resolution order, unlike a raw DNS tool). Then check `/etc/hosts` (a stale manual entry is a
classic trap) and `/etc/resolv.conf` (which DNS server is configured).

**Why `/etc/hosts` first:** it's checked before DNS, so a single wrong line there silently
overrides everything — and it's the kind of thing someone added months ago "to test."

## Website / application down (but host is reachable)

**Why it happens.** The service isn't running, isn't listening on the expected port, crashed on
start, or a firewall blocks the port.

**How to diagnose (in order).**

1. `ss -tulpn | grep :<port>` — is *anything* listening on the expected port? Nothing listening is
   the most common cause.
2. `systemctl status <service>` — is the service actually active? Did it fail on start?
3. `journalctl -u <service> -n 50` — the real error if it failed.
4. `sudo ufw status verbose` — is the firewall dropping the port?

**The inference chain:** reachable host + nothing on the port = service problem; something on the
port but still refused = firewall or the app rejecting you.

## Can't SSH

SSH gets its own attention because it's how you get *in* to fix everything else, and it fails in
specific, recognisable ways.

**Why it happens (the usual suspects).**

- **Key permissions too open.** SSH refuses to use a private key (or `authorized_keys`) that other
  users could read. `~/.ssh` must be `700`, private keys `600`, `authorized_keys` `600`. This is
  the single most common "my key worked yesterday" cause.
- **Server policy.** `sshd` may forbid what you're trying: `PermitRootLogin no` blocks root,
  `PasswordAuthentication no` forces keys, `AllowUsers` restricts who may log in.
- **Service or firewall.** The SSH server isn't running, or port 22 is blocked.

**How to diagnose.**

1. `ssh -v user@host` — the verbose handshake shows *where* it fails (auth method, key offered,
   rejection point).
2. Check local key perms: `ls -ld ~/.ssh && ls -l ~/.ssh`.
3. On the server: `systemctl status ssh`, `sudo journalctl -u ssh -n 50` for the rejection reason,
   and the policy lines in `/etc/ssh/sshd_config`.

**Why `ssh -v` first:** it tells you whether you even reached the server, which key was offered, and
whether the rejection was auth vs connection — collapsing the search instantly.

## Firewall blocking

**Why it happens.** A rule denies the port, or the default policy drops anything not explicitly
allowed.

**How to diagnose / fix.** `sudo ufw status verbose` shows rules and default policy. Allow a port
with `sudo ufw allow 22/tcp`. The trap to understand: with a default-deny policy, a service can be
running perfectly and still be unreachable — the firewall, not the app, is saying no.

## Terminal / client-side issues

Sometimes the server is fine and the **client** is the problem: a misconfigured SSH/terminal client,
wrong host/port/key in the client profile, or a local network blocking outbound. The lesson: when
everything server-side checks out, **test from a second client/machine** to decide whether the fault
is the server or your client.

---

## Check yourself

- Recite the connectivity layer order from your machine to the app. Why test in that order?
- "Pings by IP but not by hostname" — what does that isolate, and what two files do you check?
- Host is reachable but the website is down — what's your first command and why?
- Name three reasons an SSH login is refused, and what `ssh -v` tells you.
- What permissions must `~/.ssh`, a private key, and `authorized_keys` have, and why does SSH care?
- How can a perfectly running service still be unreachable, and how do you confirm it's the firewall?
