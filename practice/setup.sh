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
  "$DEVSTATION/scripts" \
  "$DEVSTATION/data" \
  "$DEVSTATION/scenarios/01-permission-denied" \
  "$DEVSTATION/scenarios/02-disk-space" \
  "$DEVSTATION/scenarios/03-service-down" \
  "$DEVSTATION/scenarios/04-ssh-locked"

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

# ─── README ──────────────────────────────────────────────────────────────────

cat > "$DEVSTATION/README.md" << 'EOF'
# devstation — Practice Environment

A simulated developer workstation. Use it to practice commands on real-looking data.

## What's here

| Directory | Use for |
|-----------|---------|
| `logs/` | grep, tail, awk, log analysis, process logs |
| `configs/` | Reading and editing config files, understanding formats |
| `scripts/` | Bash scripting — fix bugs, complete incomplete scripts, study working examples |
| `data/` | CSV processing with awk, cut, sort, grep |
| `scenarios/` | Troubleshooting practice — read the README in each scenario |

## How to use it

```bash
cd practice/devstation

# Section 01 practice
tail -f logs/app.log
grep "ERROR" logs/app.log
grep -c "ERROR\|CRITICAL" logs/app.log

# Section 06 text processing
awk -F',' '{print $1, $4}' data/users.csv
grep "401\|403\|500" logs/access.log | wc -l

# Section 07 bash scripting
cat scripts/deploy.sh     # find the 2 bugs
cat scripts/backup.sh     # complete the TODOs
bash scripts/monitor.sh   # study a working script
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
