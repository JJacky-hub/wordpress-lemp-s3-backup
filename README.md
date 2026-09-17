# Production-Ready WordPress Infrastructure & AWS S3 Backup

Automated, secure, and lightweight infrastructure setup for WordPress on LEMP stack (Linux, Nginx, MariaDB, PHP-FPM) with automated backup integration to AWS S3.

## Features
- Nginx Security Hardening: Blocked xmlrpc.php, prevented PHP execution inside /uploads/, optimized static file caching.
- WP-CLI Automation: Fast database exports and migrations without GUI overhead.
- Automated Backups: Bash script (backup.sh) handles DB dumps, file compression, and AWS S3 uploads.

## Project Structure
.
├── backup.sh             # Bash automation script for DB & file backups
├── nginx/
│   └── wordpress.conf    # Production Nginx virtual host with security rules
├── .gitignore
└── README.md

## Quick Start
1. Make the script executable:
   chmod +x backup.sh

2. Run backup manually:
   ./backup.sh

3. Configure daily automated backup via Cron (crontab -e):
   0 3 * * * /bin/bash /path/to/backup.sh > /dev/null 2>&1
