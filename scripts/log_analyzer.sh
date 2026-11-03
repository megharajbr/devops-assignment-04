
#!/bin/bash
# Purpose: Analyze application log files
# Author: Ubuntu User
# Date: 2026-11-02
# Usage: ./log_analyzer.sh <logfile>

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <logfile>"
    exit 2
fi

LOG_FILE="$1"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
REPORT_DIR="$PROJECT_DIR/reports"

if [ ! -f "$LOG_FILE" ]; then
    echo "ERROR: Log file does not exist"
    exit 1
fi

mkdir -p "$REPORT_DIR"

TOTAL_LINES=$(wc -l < "$LOG_FILE")
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE" || true)
WARNING_COUNT=$(grep -c "WARNING" "$LOG_FILE" || true)

REPORT_FILE="$REPORT_DIR/log_report_$(date +%Y%m%d_%H%M%S).txt"

{
    echo "Log Analysis Report"
    echo "-------------------"
    echo "File: $LOG_FILE"
    echo "Total lines: $TOTAL_LINES"
    echo "ERROR count: $ERROR_COUNT"
    echo "WARNING count: $WARNING_COUNT"

    echo ""
    echo "Last 5 lines:"
    tail -5 "$LOG_FILE"
} | tee "$REPORT_FILE"

echo ""
echo "Report saved to: $REPORT_FILES"
