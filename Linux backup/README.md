## Function
This is a Bash script that backs up files from your input directory to the destination you defined.

## How to use
**Basic usage with defaults:** (Backups all files in Documents folder to Backups folder under HOME directory.)
./backup_script.sh

**Specify source and destination:**
./backup_script.sh /path/to/source /path/to/backups

**Specify only source (uses default destination):**
./backup_script.sh /path/to/source

With all use cases, a backup_log.txt will be created under the HOME directory.
