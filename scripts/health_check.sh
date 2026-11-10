#!/bin/bash
# Purpose: Monitor Linux services
# Author: Ubuntu User
# Date: 2026-11-02
# Usage: ./service_monitor.sh ssh cron nginx

set -euo pipefail

# Check whether arguments are provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 service1 service2 ..."
    exit 2
fi

# Find project directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Log file location
LOG_FILE="$PROJECT_DIR/application/logs/service_status.log"
mkdir -p "$(dirname "$LOG_FILE")"
# Track service health
ALL_HEALTHY=true

# Check each service
for service in "$@"
do
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

    if systemctl is-active --quiet "$service"; then
        STATUS="[OK]"
    else
        STATUS="[FAIL]"
        ALL_HEALTHY=false
    fi

    MESSAGE="[$TIMESTAMP] $STATUS $service"

    echo "$MESSAGE"
    echo "$MESSAGE" >> "$LOG_FILE"
done

# Exit status
if [ "$ALL_HEALTHY" = true ]; then
    exit 0
else
    exit 1
fi
