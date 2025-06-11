# EC2 Log Backup to S3 Automation
## Overview
This Bash script automates the backup of log files from an EC2 instance to Amazon S3. It compresses logs, organizes them by hostname, and includes cleanup functionality.

## Features
- Automated compression and backup of log files
- Hostname-based organization in S3
- Local backup management with configurable retention
- Detailed logging of backup operations

## How to use
1. Import this script file into EC2 under you preferred location (e.g., /usr/bin).
2. Then, make this Script Executable.
```bash
sudo chmod +x /usr/bin/log_backup_to_s3.sh
```
3. Set Up a Cron Job to automatically run this script at your desiered time and with your own configuration.
  - ```bash
    sudo crontab -e
    ```
  - Add the following line to run the backup daily at 4 AM:
  - ```text
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

If crontab is missing, install the cron package with following command:
```bash
sudo yum install cronie
```
