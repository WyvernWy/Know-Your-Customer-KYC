#!/bin/bash

# Simple File Backup Script
# Usage: ./backup_script.sh [source_directory] [destination_directory]

# Set default values
DEFAULT_SRC="$HOME/Documents"
DEFAULT_DST="$HOME/Backups"
LOG_FILE="$HOME/backup_log.txt"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if source and destination are provided as arguments
if [ $# -ge 1 ]; then
    SRC_DIR="$1"
    # If second argument isn't provided, use default destination
    DST_DIR="${2:-$DEFAULT_DST}"
else
    SRC_DIR="$DEFAULT_SRC"
    DST_DIR="$DEFAULT_DST"
fi

# Validate source directory
if [ ! -d "$SRC_DIR" ]; then
    echo -e "${RED}Error: Source directory $SRC_DIR does not exist.${NC}"
    exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$DST_DIR"
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to create destination directory $DST_DIR.${NC}"
    exit 1
fi

# Create timestamp for backup
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_NAME="backup_$(basename "$SRC_DIR")_$TIMESTAMP.tar.gz"

# Log function
log() {
    local message="$1"
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$timestamp] $message" | tee -a "$LOG_FILE"
}

# Start backup process
log "Starting backup of $SRC_DIR to $DST_DIR/$BACKUP_NAME"

# Create compressed tar archive
tar -czf "$DST_DIR/$BACKUP_NAME" -C "$(dirname "$SRC_DIR")" "$(basename "$SRC_DIR")"

# Check if backup was successful
if [ $? -eq 0 ]; then
    log "${GREEN}Backup completed successfully.${NC}"
    
    # Get backup size
    BACKUP_SIZE=$(du -h "$DST_DIR/$BACKUP_NAME" | cut -f1)
    log "Backup size: $BACKUP_SIZE"
    
    # List all backups and count them
    BACKUP_COUNT=$(ls -1 "$DST_DIR"/backup_* 2>/dev/null | wc -l)
    log "Total backups in destination: $BACKUP_COUNT"
else
    log "${RED}Backup failed!${NC}"
    exit 1
fi

# Optional: Clean up old backups (keep last 5)
ls -t "$DST_DIR"/backup_* | tail -n +6 | xargs rm -f 2>/dev/null
if [ $? -eq 0 ]; then
    log "Cleaned up old backups (kept last 5)."
fi

exit 0
