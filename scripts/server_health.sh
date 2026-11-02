
#!/bin/bash
# Purpose: Display server health information
# Author: Ubuntu User
# Date: 2026-11-02
# Usage: ./server_health.sh

set -euo pipefail

echo "================================"
echo "       SERVER HEALTH REPORT"
echo "================================"

# Hostname
echo "Hostname: $(hostname)"

# Current user
echo "Current User: $(whoami)"

# Date and time
echo "Date and Time: $(date)"

# CPU core count
echo "CPU Cores: $(nproc)"

# Memory information
echo "Total Memory: $(free -h | awk '/Mem:/ {print $2}')"
echo "Available Memory: $(free -h | awk '/Mem:/ {print $7}')"

# Disk usage
DISK_USAGE=$(df -P / | awk 'NR==2 {gsub(/%/,"",$5); print $5}')

echo "Disk Usage: ${DISK_USAGE}%"

if [ "$DISK_USAGE" -gt 80 ]; then
    echo "WARNING: Disk usage is above 80%"
fi

# System uptime
echo "Uptime: $(uptime -p)"

echo "================================"
echo "       REPORT COMPLETED"
echo "================================"

