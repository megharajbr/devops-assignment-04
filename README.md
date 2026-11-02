
# DevOps Assignment 04

## Project Overview
This project demonstrates Linux administration, Bash scripting,
system monitoring, log analysis and backup management.

## Directory Structure

- application/ - Application files and configuration
- scripts/ - Bash automation scripts
- backups/ - Compressed backups
- reports/ - Generated reports

## Scripts

1. server_health.sh - Displays server health information.
2. service_monitor.sh - Checks Linux service status.
3. log_analyzer.sh - Analyzes application logs.
4. backup_manager.sh - Creates and manages backups.
5. user_audit.sh - Audits Linux user accounts.

## How to Run

Make scripts executable:

chmod +x scripts/*.sh

Run server health check:

./scripts/server_health.sh

Check services:

./scripts/service_monitor.sh ssh cron

Analyze logs:

./scripts/log_analyzer.sh application/logs/application.log

Create backup:

./scripts/backup_manager.sh application

Audit users:

./scripts/user_audit.sh
