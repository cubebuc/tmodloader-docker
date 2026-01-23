#!/bin/sh

# Arguments: $1 = Folder Name (hourly/daily), $2 = How many to keep
TYPE=$1
KEEP=$2
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="/app/data/backups"
TARGET="$BACKUP_DIR/$TYPE"
FILE="$TARGET/backup_$DATE.tar.gz"

mkdir -p $TARGET

echo "[$TYPE] Creating backup..."
tar -czf $FILE -C /app/data/tModLoader Worlds

# Keep only last X
echo "[$TYPE] Cleaning up old backups, keeping last $KEEP..."
ls -tp $TARGET/*.tar.gz | grep -v '/$' | tail -n +$(($KEEP + 1)) | xargs -I {} rm -- {}

#chown -R 1001:1001 $BACKUP_DIR

echo "[$TYPE] Done."
