# EC2 Log Backup to S3 Automation
## Overview
This Bash script automates the backup of log files from an EC2 instance to Amazon S3. It compresses logs, organizes them by hostname, and includes cleanup functionality.

## Features
- Automated compression and backup of log files
- Hostname-based organization in S3
- Local backup management with configurable retention
- Detailed logging of backup operations

## Prerequisites
- AWS CLI installed and configured
- EC2 instance with proper IAM permissions for S3 write access
- Cron service installed (cronie on Amazon Linux)

## Installation
1. **Copy the script** to your preferred location: (e.g., /usr/bin)
```bash
sudo cp log_backup_to_s3.sh /usr/local/bin/
```
2. **Make the script executable**:
```bash
sudo chmod +x /usr/bin/log_backup_to_s3.sh
```
3. **Install cron if missing** (Amazon Linux/RHEL/CentOS):
```bash
sudo yum install -y cronie
sudo systemctl enable crond
sudo systemctl start crond
```
## Configuration
**Script Configuration**

Edit the script to configure these variables:
```bash
LOG_DIR="/var/log"                # Source directory for logs
BACKUP_DIR="/tmp/log_backups"     # Temporary backup location
S3_BUCKET="your-bucket-name"      # Destination S3 bucket
S3_PATH="logs/$(hostname)"        # S3 path (includes hostname)
RETENTION_DAYS=30                 # Days to keep local backups
```
**Cron Job Setup**
Set up automated execution:
```bash
sudo crontab -e
```
Add this line for daily execution at 4 AM:
```text
0 4 * * * /usr/bin/log_backup_to_s3.sh >> /var/log/log_backup.log 2>&1
```

Cron Time Format Explanation:
The cron time format consists of five fields:
```text
* * * * * command_to_execute
│ │ │ │ │
│ │ │ │ └── Day of week (0-6, 0=Sunday)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

## Verification
1. **Test the script manually**:
```bash
sudo /usr/bin/log_backup_to_s3.sh
```
2. **Check the output**:
```bash
tail -f /var/log/log_backup.log
```
3. **Verify S3 uploads**:
```bash
aws s3 ls s3://your-bucket-name/logs/$(hostname)/
```
