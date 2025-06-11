#!/bin/bash

# Configuration
LOG_DIR="/var/log"                   # Directory containing logs to backup
BACKUP_DIR="/tmp/log_backups"        # Temporary backup directory
S3_BUCKET="bwtestbackup"             # Your S3 bucket name
S3_PATH="logs/$(hostname)"           # Path in S3 (includes hostname)
DATE=$(date +%Y-%m-%d_%H-%M-%S)      # Timestamp for backup files
RETENTION_DAYS=3                     # Days to keep local backups

# Create backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Compress and archive logs
echo "Starting log backup at $(date)"

# Backup system logs
for log_file in $(find "$LOG_DIR" -name "*.log"); do
    base_name=$(basename "$log_file")
    backup_file="$BACKUP_DIR/${base_name}_${DATE}.gz"
    echo "Compressing $log_file to $backup_file"
    gzip -c "$log_file" > "$backup_file"
    
    # Upload to S3
    s3_key="$S3_PATH/${base_name}_${DATE}.gz"
    echo "Uploading $backup_file to s3://$S3_BUCKET/$s3_key"
    aws s3 cp "$backup_file" "s3://$S3_BUCKET/$s3_key"
    
    # Verify upload
    if [ $? -eq 0 ]; then
        echo "Upload successful"
        # Remove the local backup file after successful upload
        rm -f "$backup_file"
    else
        echo "Upload failed, keeping local backup"
    fi
done

# Clean up old local backups (if any remain)
find "$BACKUP_DIR" -name "*.gz" -mtime +$RETENTION_DAYS -delete

echo "Log backup completed at $(date)"