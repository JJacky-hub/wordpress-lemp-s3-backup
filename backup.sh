#!/bin/bash

# Настройки
SITE_PATH="/var/www/wordpress"
BACKUP_DIR="/tmp/wp_backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILE_NAME="wp_backup_$DATE.tar.gz"

# AWS S3 настройки (заполняются при наличии бакета)
S3_BUCKET="s3://my-wordpress-backups-bucket"

echo "[+] Начиная процесс бэкапа для $SITE_PATH..."

# 1. Создаем временную директорию
mkdir -p $BACKUP_DIR

# 2. Делаем дамп БД через WP-CLI
cd $SITE_PATH
wp db export $BACKUP_DIR/db.sql --allow-root > /dev/null

# 3. Архивируем базу и файлы wp-content
tar -czf $BACKUP_DIR/$FILE_NAME -C $SITE_PATH wp-content -C $BACKUP_DIR db.sql

# 4. Выгружаем в AWS S3 (раскомментировать при настройке AWS CLI)
# aws s3 cp $BACKUP_DIR/$FILE_NAME $S3_BUCKET/

# 5. Очистка временных файлов
rm -rf $BACKUP_DIR/db.sql

echo "[SUCCESS] Бэкап успешно создан: $BACKUP_DIR/$FILE_NAME"
