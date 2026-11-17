#!/bin/bash

# Linux Log Cleanup Automation

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

LOG_DIR="$PROJECT_DIR/logs"
CLEANUP_LOG="$LOG_DIR/cleanup.log"

DAYS="${1:-7}"
MODE="${2:-preview}"

if ! [[ "$DAYS" =~ ^[0-9]+$ ]] || (( DAYS < 1 )); then
    echo "ERROR: Days must be a positive integer."
    exit 1
fi

if [[ "$MODE" != "preview" && "$MODE" != "delete" ]]; then
    echo "Usage: $0 [days] [preview|delete]"
    exit 1
fi

echo "=================================="
echo "       LOG CLEANUP TOOL"
echo "=================================="

echo "Log directory: $LOG_DIR"
echo "Retention period: $DAYS days"
echo "Mode: $MODE"

if [[ "$MODE" == "preview" ]]; then

    echo ""
    echo "PREVIEW: Files eligible for cleanup"

    find "$LOG_DIR" -maxdepth 1 -type f -name "*.log" -mtime +"$DAYS" -print

    echo ""
    echo "No files were deleted."

else

    echo ""
    echo "Deleting old log files..."

    while IFS= read -r -d '' file; do

        if rm -- "$file"; then
            echo "Deleted: $file"
            echo "[$(date)] DELETED: $file" >> "$CLEANUP_LOG"
        fi

    done < <(find "$LOG_DIR" -maxdepth 1 -type f -name "*.log" -mtime +"$DAYS" -print0)

fi

echo ""
echo "LOG CLEANUP COMPLETED"
