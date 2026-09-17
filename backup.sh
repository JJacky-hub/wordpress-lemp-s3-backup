#!/bin/bash

#Settings
SITE_PATH="/var/www/wordpress"
BACKUP_DIR="/tmp/wp_backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILE_NAME="wp_backup_$DATE.tar.gz"

# AWS S3 settings
S3_BUCKET="s3://my-wordpress-backups-bucket"

echo "[+] Starting backup process for $SITE_PATH..."

# 1. Create a new directory
mkdir -p $BACKUP_DIR

# 2. Damp DB using WP-CLI
cd $SITE_PATH
wp db export $BACKUP_DIR/db.sql --allow-root > /dev/null

# 3. Archieve the database and files wp-content
tar -czf $BACKUP_DIR/$FILE_NAME -C $SITE_PATH wp-content -C $BACKUP_DIR db.sql

# 4. Upload to AWS S3 (uncomment after AWS CLI setup)
# aws s3 cp $BACKUP_DIR/$FILE_NAME $S3_BUCKET/

# 5. Clean up temporary files
rm -rf $BACKUP_DIR/db.sql

echo "[SUCCESS] Backup successfully created: $BACKUP_DIR/$FILE_NAME"
