#!/bin/bash

# -----------------------------
# CONFIGURATION
# -----------------------------
DB_NAME="your_db_name"
DB_USER="your_user"
DB_PASSWORD="your_password"
DB_HOST="localhost"

S3_BUCKET="s3://your-bucket-name/mysql-backups"

BACKUP_DIR="/tmp/mysql-backups"
DATE=$(date +%F-%H-%M)
FILE_NAME="${DB_NAME}_backup_${DATE}.sql"
FILE_PATH="${BACKUP_DIR}/${FILE_NAME}"

LOG_FILE="/var/log/mysql_backup.log"

# -----------------------------
# CREATE BACKUP DIRECTORY
# -----------------------------
mkdir -p $BACKUP_DIR

echo "[$(date)] Starting MySQL backup..." >> $LOG_FILE

# -----------------------------
# TAKE BACKUP
# -----------------------------
mysqldump -h $DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME > $FILE_PATH

if [ $? -ne 0 ]; then
    echo "[$(date)] ERROR: MySQL backup failed!" >> $LOG_FILE
    exit 1
fi

echo "[$(date)] Backup created: $FILE_PATH" >> $LOG_FILE

# -----------------------------
# UPLOAD TO S3
# -----------------------------
aws s3 cp $FILE_PATH $S3_BUCKET/

if [ $? -ne 0 ]; then
    echo "[$(date)] ERROR: Upload to S3 failed!" >> $LOG_FILE
    exit 1
fi

echo "[$(date)] Backup uploaded to S3 successfully" >> $LOG_FILE

# -----------------------------
# DELETE LOCAL FILE
# -----------------------------
rm -f $FILE_PATH

if [ $? -ne 0 ]; then
    echo "[$(date)] WARNING: Failed to delete local backup" >> $LOG_FILE
else
    echo "[$(date)] Local backup deleted" >> $LOG_FILE
fi

echo "[$(date)] Backup process completed successfully" >> $LOG_FILE
