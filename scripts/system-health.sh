#!/bin/bash

# Linux System Health Monitoring Tool

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LOG_FILE="$PROJECT_DIR/logs/system-health.log"

HOSTNAME=$(hostname)
DATE=$(date)

echo "=================================="
echo "       SYSTEM HEALTH REPORT"
echo "=================================="

echo "Hostname: $HOSTNAME"
echo "Date: $DATE"

echo ""
echo "CPU LOAD CHECK"

CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
CPU_CORES=$(nproc)

echo "CPU Load: $CPU_LOAD"
echo "Available CPU Cores: $CPU_CORES"

if awk -v cpu_load="$CPU_LOAD" -v cores="$CPU_CORES" \
    'BEGIN {exit !(cpu_load >= cores)}'
then
    echo "WARNING: High CPU load detected!"
else
    echo "CPU Status: HEALTHY"
fi

echo ""
echo "MEMORY CHECK"

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')

echo "Memory Usage: $MEMORY_USAGE%"

if (( MEMORY_USAGE >= 80 )); then
    echo "WARNING: High memory usage!"
else
    echo "Memory Status: HEALTHY"
fi

echo ""
echo "DISK CHECK"

DISK_USAGE=$(df -P / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "Root Disk Usage: $DISK_USAGE%"

if (( DISK_USAGE >= 80 )); then
    echo "WARNING: High disk usage!"
else
    echo "Disk Status: HEALTHY"
fi

echo ""
echo "=================================="
echo "       HEALTH CHECK COMPLETED"
echo "=================================="

echo "[$DATE] Host: $HOSTNAME | CPU Load: $CPU_LOAD | Memory: $MEMORY_USAGE% | Disk: $DISK_USAGE%" >> "$LOG_FILE"

echo "Report saved to: $LOG_FILE"
