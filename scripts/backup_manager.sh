
#!/bin/bash
# Purpose: Create and manage application backups
# Author: Ubuntu User
# Date: 2026-11-02
# Usage: ./backup_manager.sh <source_directory>

set -euo pipefail

# Check arguments
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <source_directory>"
    exit 2
fi

SOURCE_DIR="$1"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
BACKUP_DIR="$PROJECT_DIR/backups"

# Check source directory
if [ ! -d "$SOURCE_DIR" ]; then
    echo "ERROR: Source directory does not exist"
    exit 1
fi

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Generate timestamp
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')

BACKUP_FILE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

# Create compressed backup
if tar -czf "$BACKUP_FILE" -C "$(dirname "$SOURCE_DIR")" "$(basename "$SOURCE_DIR")"; then

    # Verify backup
    if tar -tzf "$BACKUP_FILE" > /dev/null; then
        echo "Backup successful: $BACKUP_FILE"
    else
        echo "ERROR: Backup verification failed"
        exit 1
    fi

else
    echo "ERROR: Backup creation failed"
    exit 1
fi

# Keep only latest 3 backups
BACKUP_COUNT=$(find "$BACKUP_DIR" -maxdepth 1 -type f -name 'backup_*.tar.gz' | wc -l)

if [ "$BACKUP_COUNT" -gt 3 ]; then
    find "$BACKUP_DIR" -maxdepth 1 -type f -name 'backup_*.tar.gz' \
        -printf '%f\n' | sort -r | tail -n +4 |
        while IFS= read -r file; do
            rm -f "$BACKUP_DIR/$file"
        done
fi

echo "Current backups:"
ls -lh "$BACKUP_DIR"
