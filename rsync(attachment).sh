#!/bin/bash

# Локальная директория с вложениями Jira DC
SOURCE_DIR="/var/atlassian/application-data/jira/data/attachments/"

# Параметры удаленного сервера
REMOTE_USER="backupuser"
REMOTE_HOST="remote_backup_server_ip"
REMOTE_DIR="/mnt/backup/jira/attachments/"

# Опции rsync:
# -a : архивный режим (сохраняет права, владельцев, рекурсию)
# -v : вывод информации (verbose)
# -z : сжатие при передаче
# --delete : удалять на бэкапе файлы, которых больше нет в источнике (опционально)
# -e : указываем SSH с кастомным ключом (если требуется)

rsync -avz --delete -e "ssh -i /home/jira/.ssh/id_ed25519" "$SOURCE_DIR" "$REMOTE_USER@$REMOTE_HOST:$REMOTE_DIR"


#Cron
30 2 * * * /usr/local/bin/sync_jira_attachments.sh >> /var/log/jira_attachments_rsync.log 2>&1