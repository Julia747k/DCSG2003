#!/bin/bash
source /home/ubuntu/DCSG2003_V26_group37-openrc.sh
source /home/ubuntu/base.sh

WATCH_FILE="/home/ubuntu/configs/config.json"

echo "[$(date)] Watcher started for ${WATCH_FILE}"

while /usr/bin/inotifywait -e close_write,modify,move,create,delete "$WATCH_FILE" >/dev/null 2>&1; do
	info "[$(date)] Detected update to $WATCH_FILE"
	
	# Store the updated config in bf/config (overwrite if it exists)
	/usr/local/bin/uc store put --force -f "$WATCH_FILE" bf/config > /dev/null 2>&1 \
		|| error "[$(date)] Failed to upload config (exit $?)" 
	
	# Runs update script
	/bin/bash /home/ubuntu/update_config_f.sh 

	# Prevents multiple triggers from the same save
	sleep 0.2
done
