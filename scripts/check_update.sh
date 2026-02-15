#!/bin/bash

WATCH_FILE="/home/ubuntu/configs/config.json"

while inotifywait -e close_write "$WATCH_FILE"; do
    echo "Detected update to $WATCH_FILE"

    # Stores the updated script in bf/config
    uc store put bf/config -f "$WATCH_FILE"

    # Runs update script
    bash update_config_f.sh
done

