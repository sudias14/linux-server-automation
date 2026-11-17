
# Linux Server Automation Toolkit

A Bash-based Linux server administration and automation project. It provides system information reporting, health monitoring, automated backups, log management, and scheduled task execution using Cron.

## Project Objectives

- Automate routine Linux server administration tasks.
- Monitor CPU load, memory usage, and disk usage.
- Generate compressed backups of important project files.
- Manage old log files safely.
- Schedule recurring tasks using Cron.
- Practise Git and GitHub version control.

## Technologies Used

- Ubuntu Linux
- Bash scripting
- Git and GitHub
- Cron
- Linux utilities: `tar`, `awk`, `find`, `df`, `free`
- WSL2 for the development environment

## Project Structure

```text
linux-server-automation/
├── scripts/
│   ├── system-info.sh
│   ├── system-health.sh
│   ├── backup.sh
│   └── log-cleanup.sh
├── backups/
├── logs/
├── config/
├── README.md
└── .gitignore
```

## Features

### 1. System Information

Displays:
- Hostname
- Current date
- Operating system and kernel information
- System uptime
- CPU model
- Memory information
- Disk usage

Run:

```bash
./scripts/system-info.sh
```

### 2. System Health Monitoring

Checks:
- CPU load average
- Memory usage
- Root filesystem disk usage

The script reports health warnings when configured thresholds are reached and records monitoring results in `logs/system-health.log`.

Run:

```bash
./scripts/system-health.sh
```

### 3. Automated Backup

Creates timestamped compressed archives of the `scripts/` and `config/` directories.

Backup archives are stored in `backups/`.

Run:

```bash
./scripts/backup.sh
```

List backup contents:

```bash
tar -tzf backups/server-backup-YYYYMMDD-HHMMSS.tar.gz
```

### 4. Log Cleanup

Finds log files older than a specified retention period.

Preview old logs without deleting them:

```bash
./scripts/log-cleanup.sh 7 preview
```

Delete eligible old logs:

```bash
./scripts/log-cleanup.sh 7 delete
```

**Warning:** The delete mode permanently removes matching log files. Always preview before deletion.

## Cron Automation

Cron is used to schedule recurring administrative tasks.

Current scheduled jobs:

| Schedule | Task |
|---|---|
| Every 5 minutes | System health monitoring |
| Every day at midnight | Automated backup |
| Sunday at midnight | Log cleanup (currently disabled) |

View scheduled jobs:

```bash
crontab -l
```

Edit scheduled jobs:

```bash
crontab -e
```

Check Cron service:

```bash
sudo systemctl status cron
```

## Installation and Usage

Clone the repository:

```bash
git clone git@github.com:sudias14/linux-server-automation.git
cd linux-server-automation
```

Make scripts executable if necessary:

```bash
chmod +x scripts/*.sh
```

Run any script from the project root:

```bash
./scripts/system-info.sh
./scripts/system-health.sh
./scripts/backup.sh
./scripts/log-cleanup.sh 7 preview
```

## Testing and Validation

The project has been tested for:

- Successful execution of all four Bash scripts.
- System health report generation.
- Compressed backup creation.
- Backup archive inspection and restoration.
- Log cleanup preview and deletion.
- Cron health monitoring execution.
- Cron automated backup execution.
- Git commits and GitHub SSH authentication.
- Successful GitHub push.

## Development Environment

Developed and tested using Ubuntu 26.04 LTS running under Windows Subsystem for Linux 2 (WSL2).

This is a learning project. Production deployment would require additional testing, alerting, backup retention policies, access controls, and monitoring improvements.

## Future Improvements

- Email or external monitoring alerts.
- Backup retention and rotation.
- More advanced CPU and memory monitoring.
- Configuration-driven monitoring thresholds.
- Automated testing with GitHub Actions.
- Deployment to an AWS EC2 Linux server.

## Author

**Muhammed Abdulkarim**

GitHub: [@sudias14](https://github.com/sudias14)
