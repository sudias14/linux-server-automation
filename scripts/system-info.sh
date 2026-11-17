#!/bin/bash

# Linux Server Information Tool

echo "=================================="
echo "       LINUX SERVER REPORT"
echo "=================================="

echo ""
echo "SERVER HOSTNAME:"
hostname

echo ""
echo "CURRENT DATE:"
date

echo ""
echo "OPERATING SYSTEM:"
uname -a

echo ""
echo "SYSTEM UPTIME:"
uptime

echo ""
echo "CPU INFORMATION:"
lscpu | grep "Model name"

echo ""
echo "MEMORY USAGE:"
free -h

echo ""
echo "DISK USAGE:"
df -h

echo ""
echo "=================================="
echo "       REPORT COMPLETED"
echo "=================================="
