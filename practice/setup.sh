#!/bin/bash
# practice/setup.sh — generates the devstation practice environment
# Run: bash practice/setup.sh
# Re-run anytime to reset to a clean state.
# Generated files go into practice/devstation/ (gitignored)

set -e

DEVSTATION="$(dirname "$0")/devstation"

echo "Setting up devstation practice environment..."
echo "Target: $DEVSTATION"
echo ""

# Clean and recreate
rm -rf "$DEVSTATION"
mkdir -p \
  "$DEVSTATION/logs" \
  "$DEVSTATION/configs" \
  "$DEVSTATION/system" \
  "$DEVSTATION/captures" \
  "$DEVSTATION/scripts" \
  "$DEVSTATION/data" \
  "$DEVSTATION/scenarios/01-permission-denied" \
  "$DEVSTATION/scenarios/02-disk-space" \
  "$DEVSTATION/scenarios/03-service-down" \
  "$DEVSTATION/scenarios/04-ssh-locked" \
  "$DEVSTATION/scenarios/05-dns-failure" \
  "$DEVSTATION/scenarios/06-out-of-memory" \
  "$DEVSTATION/scenarios/07-fstab-broken" \
  "$DEVSTATION/scenarios/08-root-recovery"

# ─── LOGS ────────────────────────────────────────────────────────────────────

cat > "$DEVSTATION/logs/app.log" << 'EOF'
2024-03-01 08:01:22 INFO  [api] Server started on port 8080
2024-03-01 08:01:23 INFO  [db] Connected to database at localhost:5432
2024-03-01 08:14:05 INFO  [api] GET /health 200 12ms user=system
2024-03-01 08:22:11 WARNING [auth] Failed login attempt for user: admin from 192.168.1.55
2024-03-01 08:22:14 WARNING [auth] Failed login attempt for user: admin from 192.168.1.55
2024-03-01 08:22:17 WARNING [auth] Failed login attempt for user: admin from 192.168.1.55
2024-03-01 08:22:20 ERROR  [auth] Account locked after 3 failed attempts: admin
2024-03-01 09:05:33 INFO  [api] POST /api/v1/users 201 45ms user=alice
2024-03-01 09:31:44 ERROR  [db] Connection timeout after 30s — retrying
2024-03-01 09:31:47 ERROR  [db] Connection timeout after 30s — retrying
2024-03-01 09:31:50 ERROR  [db] Connection timeout after 30s — retrying
2024-03-01 09:31:53 CRITICAL [db] Failed to reconnect after 3 attempts — shutting down worker
2024-03-01 10:00:01 INFO  [cron] Starting daily backup job
2024-03-01 10:00:45 INFO  [cron] Backup completed: 1.2GB written to /backup/2024-03-01.tar.gz
2024-03-01 11:15:22 WARNING [api] High memory usage: 87% — threshold is 80%
2024-03-01 11:45:09 INFO  [api] GET /api/v1/reports 200 1203ms user=bob
2024-03-01 12:00:00 INFO  [api] GET /api/v1/reports 200 1189ms user=carol
2024-03-01 14:22:33 ERROR  [api] POST /api/v1/upload 500 — disk quota exceeded
2024-03-01 14:22:33 ERROR  [storage] Write failed: no space left on device
2024-03-01 15:01:11 INFO  [api] DELETE /api/v1/sessions/old 200 — removed 234 expired sessions
2024-03-01 16:30:00 WARNING [api] Slow query detected: 4500ms for GET /api/v1/analytics
2024-03-01 17:00:00 INFO  [api] Server graceful shutdown initiated
2024-03-01 17:00:03 INFO  [api] Server stopped
EOF

cat > "$DEVSTATION/logs/access.log" << 'EOF'
192.168.1.10 - alice [01/Mar/2024:09:05:33 +0000] "POST /api/v1/users HTTP/1.1" 201 512
192.168.1.10 - alice [01/Mar/2024:09:10:11 +0000] "GET /api/v1/users/42 HTTP/1.1" 200 1024
192.168.1.22 - bob [01/Mar/2024:10:00:01 +0000] "GET /health HTTP/1.1" 200 18
192.168.1.33 - - [01/Mar/2024:10:15:44 +0000] "GET /admin HTTP/1.1" 403 256
192.168.1.55 - - [01/Mar/2024:10:16:00 +0000] "GET /admin HTTP/1.1" 403 256
192.168.1.55 - - [01/Mar/2024:10:16:05 +0000] "GET /../../../etc/passwd HTTP/1.1" 400 128
192.168.1.55 - - [01/Mar/2024:10:16:10 +0000] "POST /api/v1/login HTTP/1.1" 401 64
192.168.1.55 - - [01/Mar/2024:10:16:15 +0000] "POST /api/v1/login HTTP/1.1" 401 64
192.168.1.10 - carol [01/Mar/2024:12:00:00 +0000] "GET /api/v1/reports HTTP/1.1" 200 8192
192.168.1.10 - carol [01/Mar/2024:12:05:22 +0000] "GET /api/v1/reports HTTP/1.1" 200 8192
192.168.1.10 - alice [01/Mar/2024:14:22:33 +0000] "POST /api/v1/upload HTTP/1.1" 500 256
192.168.1.22 - bob [01/Mar/2024:15:01:11 +0000] "DELETE /api/v1/sessions/old HTTP/1.1" 200 128
192.168.1.10 - carol [01/Mar/2024:16:30:00 +0000] "GET /api/v1/analytics HTTP/1.1" 200 32768
192.168.1.88 - - [01/Mar/2024:16:45:00 +0000] "GET /api/v1/users HTTP/1.1" 401 64
192.168.1.88 - - [01/Mar/2024:16:45:10 +0000] "POST /api/v1/login HTTP/1.1" 401 64
192.168.1.88 - - [01/Mar/2024:16:45:20 +0000] "POST /api/v1/login HTTP/1.1" 401 64
EOF

cat > "$DEVSTATION/logs/auth.log" << 'EOF'
Mar  1 08:00:01 devstation sshd[1234]: Accepted publickey for devops from 192.168.1.10 port 54322 ssh2
Mar  1 08:22:11 devstation sshd[1235]: Failed password for admin from 192.168.1.55 port 44100 ssh2
Mar  1 08:22:14 devstation sshd[1235]: Failed password for admin from 192.168.1.55 port 44101 ssh2
Mar  1 08:22:17 devstation sshd[1235]: Failed password for invalid user root from 192.168.1.55 port 44102 ssh2
Mar  1 09:15:00 devstation sudo: alice : TTY=pts/0 ; PWD=/home/alice ; USER=root ; COMMAND=/usr/bin/apt update
Mar  1 09:15:45 devstation sudo: alice : TTY=pts/0 ; PWD=/home/alice ; USER=root ; COMMAND=/usr/bin/apt install -y htop
Mar  1 10:30:22 devstation sshd[1240]: Accepted publickey for alice from 192.168.1.10 port 55000 ssh2
Mar  1 14:00:00 devstation sudo: bob : TTY=pts/1 ; PWD=/home/bob ; USER=root ; COMMAND=/usr/bin/systemctl restart webapp
Mar  1 16:00:00 devstation sudo: FAILED - 3 incorrect password attempts ; TTY=pts/2 ; PWD=/tmp ; USER=root ; COMMAND=/bin/su
Mar  1 16:45:00 devstation sshd[1250]: Failed password for invalid user hack from 192.168.1.88 port 12345 ssh2
Mar  1 16:45:10 devstation sshd[1250]: Failed password for invalid user hack from 192.168.1.88 port 12346 ssh2
EOF

cat > "$DEVSTATION/logs/system.log" << 'EOF'
Mar  1 07:55:00 devstation kernel: [    0.000000] Booting Linux on physical CPU 0x0
Mar  1 07:55:02 devstation systemd[1]: Started Session 1 of user devops.
Mar  1 07:55:03 devstation systemd[1]: Started nginx.service - A high performance web server
Mar  1 07:55:04 devstation systemd[1]: Started webapp.service - Web Application
Mar  1 09:31:44 devstation kernel: Out of memory: Kill process 4521 (python3) score 312 or sacrifice child
Mar  1 09:31:44 devstation kernel: Killed process 4521 (python3) total-vm:2048000kB, anon-rss:1500000kB
Mar  1 09:31:47 devstation systemd[1]: webapp.service: Main process exited, code=killed, status=9/KILL
Mar  1 09:31:47 devstation systemd[1]: webapp.service: Failed with result 'signal'.
Mar  1 09:31:50 devstation systemd[1]: webapp.service: Scheduled restart job, restart counter is at 1.
Mar  1 09:31:53 devstation systemd[1]: Started webapp.service - Web Application
Mar  1 14:22:33 devstation kernel: EXT4-fs error (device sdb1): ext4_find_entry:1455: inode #2: comm app: reading directory lblock 0
Mar  1 16:59:58 devstation systemd[1]: Stopping webapp.service - Web Application
Mar  1 17:00:00 devstation systemd[1]: webapp.service: Deactivated successfully.
EOF

# ─── CONFIGS ─────────────────────────────────────────────────────────────────

cat > "$DEVSTATION/configs/nginx.conf" << 'EOF'
server {
    listen 80;
    server_name devstation.local;

    location / {
        proxy_pass http://127.0.0.1:8080;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /static {
        root /var/www/html;
        expires 30d;
    }

    # Missing: access_log and error_log directives
    # Missing: gzip compression
}
EOF

cat > "$DEVSTATION/configs/webapp.service" << 'EOF'
[Unit]
Description=Web Application
After=network.target postgresql.service

[Service]
Type=simple
User=www-data
WorkingDirectory=/opt/webapp
ExecStart=/usr/bin/python3 /opt/webapp/app.py
Restart=on-failure
RestartSec=5
Environment=PORT=8080
Environment=DB_HOST=localhost

[Install]
WantedBy=multi-user.target
EOF

cat > "$DEVSTATION/configs/crontab.example" << 'EOF'
# Example crontab entries — copy with: crontab crontab.example
# Format: minute hour day-of-month month day-of-week command

# Daily backup at 2am
0 2 * * * /opt/webapp/scripts/backup.sh >> /var/log/backup.log 2>&1

# Clear old sessions every hour
0 * * * * /opt/webapp/scripts/cleanup.sh

# Health check every 5 minutes
*/5 * * * * curl -sf http://localhost:8080/health > /dev/null || systemctl restart webapp

# Weekly report every Monday at 9am
0 9 * * 1 /opt/webapp/scripts/report.sh | mail -s "Weekly Report" admin@example.com
EOF

cat > "$DEVSTATION/configs/hosts.example" << 'EOF'
# /etc/hosts practice file — do NOT replace your real /etc/hosts
# Study this, understand the format, then add to your real /etc/hosts if needed

127.0.0.1   localhost
127.0.1.1   devstation

# Development aliases (add to real /etc/hosts for local dev)
127.0.0.1   api.local
127.0.0.1   app.local
127.0.0.1   db.local

# Block known ad domains by pointing to localhost (example)
0.0.0.0     ads.example.com
0.0.0.0     tracker.example.com
EOF

cat > "$DEVSTATION/configs/netplan.yaml" << 'EOF'
# Example netplan config — study the format, do NOT apply this on your machine.
# Real path on Ubuntu: /etc/netplan/01-netcfg.yaml  (apply with: sudo netplan apply)
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: false
      addresses:
        - 192.168.1.50/24
      routes:
        - to: default
          via: 192.168.1.1
      nameservers:
        addresses: [1.1.1.1, 8.8.8.8]
EOF

cat > "$DEVSTATION/configs/fstab.example" << 'EOF'
# Example /etc/fstab — study the columns, do NOT replace your real /etc/fstab.
# <device>            <mount point>  <type>  <options>          <dump> <pass>
UUID=11aa-22bb-33cc   /              ext4    defaults             0      1
UUID=44dd-55ee-66ff   /boot          ext4    defaults             0      2
UUID=77gg-88hh-99ii   /home          ext4    defaults,nodev       0      2
/dev/vg0/data         /opt/webapp    ext4    defaults,noatime     0      2
/swap.img             none           swap    sw                   0      0
tmpfs                 /tmp           tmpfs   defaults,nosuid      0      0
EOF

cat > "$DEVSTATION/configs/resolv.conf" << 'EOF'
# Example resolv.conf — name resolution settings.
nameserver 127.0.0.53
nameserver 1.1.1.1
search local example.com
options edns0 trust-ad
EOF

# ─── SYSTEM (fake account databases — safe to read, NOT your real ones) ──────

cat > "$DEVSTATION/system/passwd" << 'EOF'
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
www-data:x:33:33:www-data:/var/www:/usr/sbin/nologin
sshd:x:104:65534::/run/sshd:/usr/sbin/nologin
postgres:x:111:117:PostgreSQL administrator:/var/lib/postgresql:/bin/bash
alice:x:1001:1001:Alice Adams,Engineering:/home/alice:/bin/bash
bob:x:1002:1002:Bob Brown,DevOps:/home/bob:/bin/bash
carol:x:1003:1003:Carol Clark,Analytics:/home/carol:/bin/bash
dave:x:1004:1004:Dave Davis,Engineering:/home/dave:/usr/sbin/nologin
deploy:x:1005:1005:Deploy Service Account:/home/deploy:/bin/bash
EOF

cat > "$DEVSTATION/system/group" << 'EOF'
root:x:0:
sudo:x:27:alice,bob
www-data:x:33:deploy
postgres:x:117:
developers:x:1500:alice,dave,grace
devops:x:1501:bob,deploy
analytics:x:1502:carol
EOF

cat > "$DEVSTATION/system/shadow" << 'EOF'
# Fake shadow file — passwords are placeholders, not real hashes.
# Fields: name:password:lastchange:min:max:warn:inactive:expire:
root:!:19500:0:99999:7:::
alice:$6$fakeSALT$fakeHASHvalue00000000000000000:19700:0:90:7:::
bob:$6$fakeSALT$fakeHASHvalue11111111111111111:19710:0:90:7:14::
carol:$6$fakeSALT$fakeHASHvalue22222222222222222:19650:0:99999:7:::
dave:!:19400:0:99999:7::19800:
deploy:*:19500:0:99999:7:::
EOF

# ─── CAPTURES (saved command output — practice reading/parsing without root) ──

cat > "$DEVSTATION/captures/ps-aux.txt" << 'EOF'
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.1 168100 11800 ?        Ss   07:55   0:02 /sbin/init
root       412  0.0  0.2  98200 18400 ?        Ss   07:55   0:01 /usr/lib/systemd/systemd-journald
root       720  0.0  0.1  15600  6100 ?        Ss   07:55   0:00 /usr/sbin/sshd -D
www-data  1043 12.3  8.7 2048000 712000 ?      Sl   07:55   3:21 /usr/bin/python3 /opt/webapp/app.py
postgres  1101  0.5  4.2 1240000 345000 ?      Ss   07:55   0:44 postgres: main process
www-data  1455  0.0  0.3  72400 24800 ?        S    08:01   0:00 nginx: worker process
bob       2210  0.0  0.1  17200  9400 pts/1    Ss   14:00   0:00 -bash
bob       2310 95.1  1.2 220000 98000 pts/1    R+   14:05   2:40 python3 train_model.py
root      2401  0.0  0.0   8400  3200 ?        S    14:10   0:00 [kworker/0:2]
EOF

cat > "$DEVSTATION/captures/systemctl-units.txt" << 'EOF'
UNIT                     LOAD   ACTIVE   SUB     DESCRIPTION
nginx.service            loaded active   running A high performance web server
ssh.service              loaded active   running OpenBSD Secure Shell server
postgresql.service       loaded active   running PostgreSQL RDBMS
webapp.service           loaded failed   failed  Web Application
cron.service             loaded active   running Regular background program processing
ufw.service              loaded active   exited  Uncomplicated firewall
systemd-journald.service loaded active   running Journal Service
EOF

cat > "$DEVSTATION/captures/ss-tulpn.txt" << 'EOF'
Netid State  Local Address:Port  Peer Address:Port Process
tcp   LISTEN 0.0.0.0:22          0.0.0.0:*         users:(("sshd",pid=720,fd=3))
tcp   LISTEN 127.0.0.1:5432      0.0.0.0:*         users:(("postgres",pid=1101,fd=5))
tcp   LISTEN 0.0.0.0:80          0.0.0.0:*         users:(("nginx",pid=1455,fd=6))
tcp   LISTEN 127.0.0.1:8080      0.0.0.0:*         users:(("python3",pid=1043,fd=8))
tcp   ESTAB  192.168.1.50:22     192.168.1.10:54322 users:(("sshd",pid=1240,fd=4))
EOF

cat > "$DEVSTATION/captures/ip-addr.txt" << 'EOF'
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 state UNKNOWN group default
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 state UP group default
    link/ether 52:54:00:a1:b2:c3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.1.50/24 brd 192.168.1.255 scope global eth0
EOF

cat > "$DEVSTATION/captures/lsblk.txt" << 'EOF'
NAME         MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda            8:0    0   50G  0 disk
├─sda1         8:1    0    1G  0 part /boot
└─sda2         8:2    0   49G  0 part
  ├─vg0-root 252:0    0   25G  0 lvm  /
  └─vg0-data 252:1    0   24G  0 lvm  /opt/webapp
sdb            8:16   0   20G  0 disk
└─sdb1         8:17   0   20G  0 part /mnt/backup
EOF

cat > "$DEVSTATION/captures/df-h.txt" << 'EOF'
Filesystem            Size  Used Avail Use% Mounted on
/dev/mapper/vg0-root   25G   11G   13G  46% /
/dev/sda1             974M  210M  697M  24% /boot
/dev/mapper/vg0-data   24G   23G  840M  97% /opt/webapp
/dev/sdb1              20G  2.1G   17G  11% /mnt/backup
tmpfs                 3.9G     0  3.9G   0% /tmp
EOF

# ─── SCRIPTS ─────────────────────────────────────────────────────────────────

cat > "$DEVSTATION/scripts/deploy.sh" << 'EOF'
#!/bin/bash
# deploy.sh — deploy the web application
# STATUS: has 2 bugs — find and fix them

APP_DIR=/opt/webapp
BACKUP_DIR=/backup/deploys
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "Starting deployment at $TIMESTAMP"

# BUG 1: this should stop on error but doesn't
# (hint: what's the first line of a robust script?)

# Back up current version
mkdir $BACKUP_DIR/$TIMESTAMP
cp -r $APP_DIR/* $BACKUP_DIR/$TIMESTAMP/
echo "Backed up to $BACKUP_DIR/$TIMESTAMP"

# Pull latest code (simulated)
echo "Pulling latest code..."
sleep 1

# Restart the service
systemctl restart webapp
echo "Service restarted"

# BUG 2: we should verify the service actually started
# (hint: check the exit status of the restart command)

echo "Deployment complete"
EOF

cat > "$DEVSTATION/scripts/backup.sh" << 'EOF'
#!/bin/bash
# backup.sh — back up application data
# STATUS: incomplete — missing functions and error handling
# Your task: complete this script

set -e
set -o pipefail

BACKUP_DIR="/backup"
SOURCE_DIR="/opt/webapp/data"
RETENTION_DAYS=30
LOG_FILE="/var/log/backup.log"

# TODO: write a function called log() that:
# - takes a message as $1
# - prints: "[YYYY-MM-DD HH:MM:SS] $message" to stdout AND appends to $LOG_FILE

# TODO: write a function called cleanup_old_backups() that:
# - finds files in $BACKUP_DIR older than $RETENTION_DAYS days
# - deletes them
# - logs how many were deleted

# TODO: write the main backup logic:
# - log that backup is starting
# - check that $SOURCE_DIR exists (exit with error if not)
# - create a timestamped tarball in $BACKUP_DIR
# - log the size of the backup
# - run cleanup_old_backups
# - log that backup completed successfully

echo "Script not yet complete — implement the TODOs above"
EOF

cat > "$DEVSTATION/scripts/monitor.sh" << 'EOF'
#!/bin/bash
# monitor.sh — check system health and report
# STATUS: working — study this as a reference

set -e

WARN_CPU=80
WARN_MEM=85
WARN_DISK=90

check_cpu() {
    local cpu_idle
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | tr -d '%')
    local cpu_used=$((100 - ${cpu_idle%.*}))
    echo "CPU usage: ${cpu_used}%"
    if [ "$cpu_used" -gt "$WARN_CPU" ]; then
        echo "WARNING: CPU usage is high (${cpu_used}% > ${WARN_CPU}%)"
        return 1
    fi
    return 0
}

check_memory() {
    local mem_info
    mem_info=$(free | grep Mem)
    local total=$(echo "$mem_info" | awk '{print $2}')
    local used=$(echo "$mem_info" | awk '{print $3}')
    local pct=$(( used * 100 / total ))
    echo "Memory usage: ${pct}%"
    if [ "$pct" -gt "$WARN_MEM" ]; then
        echo "WARNING: Memory usage is high (${pct}% > ${WARN_MEM}%)"
        return 1
    fi
    return 0
}

check_disk() {
    local disk_used
    disk_used=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    echo "Disk usage (/): ${disk_used}%"
    if [ "$disk_used" -gt "$WARN_DISK" ]; then
        echo "WARNING: Disk usage is high (${disk_used}% > ${WARN_DISK}%)"
        return 1
    fi
    return 0
}

echo "=== System Health Check $(date) ==="
echo ""
check_cpu || true
check_memory || true
check_disk || true
echo ""
echo "=== Done ==="
EOF

cat > "$DEVSTATION/scripts/process_logs.sh" << 'EOF'
#!/bin/bash
# process_logs.sh — analyze access.log
# STATUS: challenge — implement each function yourself

LOGFILE="$(dirname "$0")/../logs/access.log"

# Challenge 1: count total requests
count_requests() {
    # Your solution here
    echo "TODO: count total lines in $LOGFILE"
}

# Challenge 2: count requests by HTTP status code (200, 401, 403, 500)
count_by_status() {
    # Your solution here (hint: grep + wc or awk)
    echo "TODO: show count for each status code"
}

# Challenge 3: find the IP with the most requests
top_ip() {
    # Your solution here (hint: awk + sort + uniq + head)
    echo "TODO: print the top IP and how many requests it made"
}

# Challenge 4: find all 4xx and 5xx errors and print them
show_errors() {
    # Your solution here (hint: grep with extended regex)
    echo "TODO: print all error lines"
}

echo "=== Log Analysis: $LOGFILE ==="
echo ""
echo "Total requests:"; count_requests
echo ""
echo "By status code:"; count_by_status
echo ""
echo "Top IP:"; top_ip
echo ""
echo "Errors:"; show_errors
EOF
chmod +x "$DEVSTATION/scripts/"*.sh

# ─── DATA ────────────────────────────────────────────────────────────────────

cat > "$DEVSTATION/data/users.csv" << 'EOF'
username,role,email,last_login,status,login_count
alice,admin,alice@example.com,2024-03-01,active,245
bob,developer,bob@example.com,2024-03-01,active,182
carol,analyst,carol@example.com,2024-03-01,active,93
dave,developer,dave@example.com,2024-02-15,inactive,67
eve,admin,eve@example.com,2024-02-28,active,310
frank,viewer,frank@example.com,2024-01-10,inactive,12
grace,developer,grace@example.com,2024-03-01,active,156
heidi,analyst,heidi@example.com,2024-02-20,active,44
ivan,viewer,ivan@example.com,2024-02-01,inactive,8
judy,developer,judy@example.com,2024-03-01,active,203
EOF

cat > "$DEVSTATION/data/api_logs.csv" << 'EOF'
timestamp,method,endpoint,status,response_ms,user
2024-03-01T09:05:33,POST,/api/v1/users,201,45,alice
2024-03-01T09:10:11,GET,/api/v1/users/42,200,12,alice
2024-03-01T10:00:01,GET,/health,200,3,bob
2024-03-01T10:15:44,GET,/admin,403,5,anon
2024-03-01T11:45:09,GET,/api/v1/reports,200,1203,bob
2024-03-01T12:00:00,GET,/api/v1/reports,200,1189,carol
2024-03-01T12:05:22,GET,/api/v1/reports,200,1201,carol
2024-03-01T13:30:00,PUT,/api/v1/users/42,200,67,alice
2024-03-01T14:22:33,POST,/api/v1/upload,500,234,alice
2024-03-01T15:01:11,DELETE,/api/v1/sessions/old,200,890,bob
2024-03-01T16:30:00,GET,/api/v1/analytics,200,4500,carol
2024-03-01T16:45:00,GET,/api/v1/users,401,4,anon
2024-03-01T16:45:10,POST,/api/v1/login,401,8,anon
2024-03-01T16:45:20,POST,/api/v1/login,401,8,anon
EOF

cat > "$DEVSTATION/data/servers.txt" << 'EOF'
# devstation server inventory
# format: hostname ip role status
web-01   192.168.1.10  web      active
web-02   192.168.1.11  web      active
api-01   192.168.1.20  api      active
api-02   192.168.1.21  api      maintenance
db-01    192.168.1.30  database active
db-02    192.168.1.31  database standby
cache-01 192.168.1.40  cache    active
monitor  192.168.1.50  monitor  active
EOF

# ─── SCENARIOS ───────────────────────────────────────────────────────────────

cat > "$DEVSTATION/scenarios/01-permission-denied/README.md" << 'EOF'
# Scenario: Permission Denied

## Setup (run as yourself)
```bash
mkdir -p /tmp/devstation-scenario1
echo "secret config data" > /tmp/devstation-scenario1/config.txt
chmod 000 /tmp/devstation-scenario1/config.txt
```

## The ticket
"I can't read the config file at /tmp/devstation-scenario1/config.txt.
I get 'Permission denied' even though I created it."

## Your task
Diagnose why. Fix it with the minimum permissions necessary (not chmod 777).

## You know you fixed it when
You can run `cat /tmp/devstation-scenario1/config.txt` and see "secret config data".

## Cleanup
```bash
rm -rf /tmp/devstation-scenario1
```
EOF

cat > "$DEVSTATION/scenarios/03-service-down/README.md" << 'EOF'
# Scenario: Service Won't Start

## The ticket
"The webapp service keeps failing. systemctl start webapp just says 'failed'."

## Study material
Look at `configs/webapp.service` and `logs/system.log` in the devstation.

## Your task
1. What would you check first?
2. What command tells you WHY a service failed?
3. What are the three most common reasons a systemd service fails?

## Note
This is a study scenario — you cannot actually run systemctl on this service
unless you install it. Focus on the diagnostic approach, not the fix.
EOF

cat > "$DEVSTATION/scenarios/02-disk-space/README.md" << 'EOF'
# Scenario: Disk Full

## Study material
`captures/df-h.txt` and `logs/app.log` (look for "no space left on device").

## The ticket
"Uploads are failing with 500 errors. The app log says 'disk quota exceeded'."

## Your task
1. From `captures/df-h.txt`, which mount point is the problem? How full is it?
2. Which commands would you run on a real box to find the biggest offenders?
   (hint: `du`, `sort`, `find` for large/old files)
3. Name two safe ways to reclaim space and one risky one to avoid.

## You know you understand it when
You can explain why `df` and `du` can disagree, and what a deleted-but-open file is.
EOF

cat > "$DEVSTATION/scenarios/04-ssh-locked/README.md" << 'EOF'
# Scenario: Locked Out Over SSH

## Study material
`logs/auth.log` — look at the failed/accepted authentication lines.

## The ticket
"I can't SSH into the server anymore — it just says 'Permission denied (publickey)'."

## Your task
1. From `auth.log`, separate the legitimate logins from the attack attempts.
2. List the things you'd check, in order, for a `publickey` rejection
   (key present? permissions on `~/.ssh`? right user? server config?).
3. Which file permissions on `~/.ssh` and `authorized_keys` does sshd require?

## You know you understand it when
You can explain why correct key permissions matter and what `ssh -v` would show you.
EOF

cat > "$DEVSTATION/scenarios/05-dns-failure/README.md" << 'EOF'
# Scenario: Name Resolution Broken

## Study material
`configs/resolv.conf`, `configs/hosts.example`, `configs/netplan.yaml`.

## The ticket
"The app can reach 8.8.8.8 by IP but every hostname fails with 'Name or service not known'."

## Your task
1. If ping-by-IP works but ping-by-name fails, what layer is broken?
2. Which files/commands decide how a name becomes an IP on Ubuntu?
   (hint: `/etc/hosts`, `/etc/resolv.conf`, `systemd-resolved`, `getent hosts`)
3. How would you test resolution without changing anything? (hint: `dig`, `nslookup`, `getent`)

## You know you understand it when
You can describe the order Linux uses to resolve a hostname.
EOF

cat > "$DEVSTATION/scenarios/06-out-of-memory/README.md" << 'EOF'
# Scenario: The OOM Killer Struck

## Study material
`logs/system.log` (search for "Out of memory") and `captures/ps-aux.txt`.

## The ticket
"The webapp died on its own around 09:31 and systemd restarted it. No deploy happened."

## Your task
1. In `system.log`, find who killed what and why. What does "score 312" mean?
2. From `ps-aux.txt`, which process is the memory hog right now?
3. What's the difference between a process being killed by OOM vs. crashing on its own?
4. Name two ways to reduce OOM risk (swap, limits, fixing the leak).

## You know you understand it when
You can read an OOM log line and explain each field.
EOF

cat > "$DEVSTATION/scenarios/07-fstab-broken/README.md" << 'EOF'
# Scenario: Bad fstab Won't Boot

## Study material
`configs/fstab.example` and `captures/lsblk.txt`.

## The ticket
"After editing /etc/fstab the machine drops to emergency mode on boot."

## Your task
1. A wrong UUID or a typo'd option in fstab can block boot. Why is the `<pass>` column relevant?
2. How do you get a shell to fix it when the system won't boot normally?
   (hint: recovery mode, remount root read-write)
3. How do you safely test an fstab change *before* rebooting? (hint: `mount -a`)

## You know you understand it when
You can explain what each of the six fstab columns does.
EOF

cat > "$DEVSTATION/scenarios/08-root-recovery/README.md" << 'EOF'
# Scenario: Lost the Root Password

## The ticket
"Nobody knows the root password and the only sudo user left the company."

## Your task (study the approach — do this on a throwaway VM, never production blind)
1. What is single-user / recovery mode, and how do you reach it from GRUB?
2. Why must you remount the root filesystem read-write before `passwd` will work?
3. What's the difference between recovering a VM (console access) vs. a remote box you
   can only SSH to?

## You know you understand it when
You can list the steps to reset a root password from the GRUB menu, in order.

## Safety
Never practice this on a machine you can't afford to break. Use a disposable VM.
EOF

# ─── README ──────────────────────────────────────────────────────────────────

cat > "$DEVSTATION/README.md" << 'EOF'
# devstation — Practice Environment

A simulated developer workstation. Use it to practice commands on real-looking data.

## What's here

| Directory | Use for |
|-----------|---------|
| `logs/` | grep, tail, awk, log analysis, process logs |
| `configs/` | Config formats: nginx, systemd, netplan, fstab, hosts, resolv.conf |
| `system/` | Fake `passwd`/`group`/`shadow` — practice reading account databases safely |
| `captures/` | Saved output of `ps`, `ss`, `ip`, `lsblk`, `df`, `systemctl` — parse without root |
| `scripts/` | Bash scripting — fix bugs, complete incomplete scripts, study working examples |
| `data/` | CSV processing with awk, cut, sort, grep |
| `scenarios/` | Troubleshooting practice — read the README in each scenario |

## How to use it

```bash
cd practice/devstation

# Filesystems / IO (ch2, ch5)
tail -f logs/app.log
grep "ERROR" logs/app.log
grep -c "ERROR\|CRITICAL" logs/app.log

# Users & groups (ch9)
awk -F: '$3 >= 1000 {print $1, $5}' system/passwd
grep developers system/group

# Processes, services, networking, storage (ch10, ch12, ch13)
sort -k3 -nr captures/ps-aux.txt | head     # top processes by CPU
grep LISTEN captures/ss-tulpn.txt           # what's listening
awk '$5+0 > 90' captures/df-h.txt           # near-full filesystems

# Text processing (ch14)
awk -F',' '{print $1, $4}' data/users.csv
grep "401\|403\|500" logs/access.log | wc -l

# Bash scripting (ch7)
cat scripts/deploy.sh     # find the 2 bugs
cat scripts/backup.sh     # complete the TODOs
bash scripts/monitor.sh   # study a working script

# Troubleshooting (section 03) — work each scenario's README
ls scenarios/
```

## Reset
```bash
bash practice/setup.sh
```
EOF

echo ""
echo "devstation created successfully at: $DEVSTATION"
echo ""
echo "Structure:"
find "$DEVSTATION" -not -path '*/.*' | sort | sed 's/[^/]*\//  /g'
