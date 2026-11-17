#!/bin/bash

# Linux Automated Backup Tool

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

BACKUP_DIR="$PROJECT_DIR/backups"
LOG_FILE="$PROJECT_DIR/logs/backup.log"

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

BACKUP_FILE="$BACKUP_DIR/server-backup-$TIMESTAMP.tar.gz"

echo "=================================="
echo "      LINUX BACKUP SYSTEM"
echo "=================================="

echo "Starting backup..."
echo "Date: $(date)"

# Ensure backup directory exists

mkdir -p "$BACKUP_DIR"

# Check source directories

if [[ ! -d "$PROJECT_DIR/scripts" || ! -d "$PROJECT_DIR/config" ]]; then
    echo "ERROR: Source directory missing."
    exit 1
fi

# Create compressed backup

if tar -czf "$BACKUP_FILE" -C "$PROJECT_DIR" scripts config; then

    echo "Backup completed successfully!"
    echo "Backup file: $BACKUP_FILE"

    echo "[$(date)] SUCCESS: $BACKUP_FILE" >> "$LOG_FILE"

else

    echo "ERROR: Backup failed!"

    echo "[$(date)] FAILED: Backup operation failed" >> "$LOG_FILE"

    exit 1

fi

echo "=================================="
echo "       BACKUP FINISHED"
echo "=================================="
