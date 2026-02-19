#!/bin/bash

#Lager unik backupmappe
BACKUP_DIR="/home/ubuntu/backup/backup_$(date +%F_%H-%M-%S)"

#Kjører python koden og lager mappen
if python3 /home/ubuntu/bookface/tools/backup_db.py \
	    --db-host 192.168.132.48 \
	        --pictures-blob-batch 1 \
		    --output-dir "$BACKUP_DIR" >/dev/null 2>&1
then
	#Komprimer mappen
	if tar czf "${BACKUP_DIR}.tgz" "$BACKUP_DIR" >/dev/null 2>&1
	then 

		#Sender til backupvolum
		if scp -o BatchMode=yes -o ConnectTimeout=5 \
			-i /home/ubuntu/.ssh/id_ed25519_backup \
	    		"${BACKUP_DIR}.tgz" \
	        		ubuntu@192.168.129.234:/backup/
		then 
			#Sletter lokal backup
			rm -rf "$BACKUP_DIR"
			rm -f "${BACKUP_DIR}.tgz"
			echo "$(date) Backup completed!"
		else
			echo "$(date) Couldnt connect to backup VM! Backup saved locally in ${BACKUP_DIR}"
		fi
	else
		echo "$(date) Compression failed! Backup saved locally in ${BACKUP_DIR}"
	fi
else 
	echo "$(date) Backup failed!"
fi

