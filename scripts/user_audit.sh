
#!/bin/bash
# Purpose: Audit Linux user accounts
# Author: Ubuntu User
# Date: 2026-11-02
# Usage: ./user_audit.sh

set -euo pipefail

# Function to print table header
print_header() {
    printf "%-20s %-10s %-30s %-20s\n" \
        "USERNAME" "UID" "HOME DIRECTORY" "SHELL"

    echo "--------------------------------------------------------------------------"
}

# Initialize counter
COUNT=0

echo "Linux User Audit Report"
echo "======================="

print_header

# Read /etc/passwd line by line
while IFS=: read -r username password uid gid gecos home shell
do

    # Check UID is 1000 or greater
    if [ "$uid" -ge 1000 ]; then

        printf "%-20s %-10s %-30s %-20s\n" \
            "$username" "$uid" "$home" "$shell"

        COUNT=$((COUNT + 1))
    fi

done < /etc/passwd

echo ""
echo "Total users with UID >= 1000: $COUNT"
