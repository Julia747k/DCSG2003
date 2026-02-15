#!/bin/bash

source /home/ubuntu/DCSG2003_V26_group37-openrc.sh

for server in $(openstack server list | grep Ubu | grep -v manager | awk '{ print $8 $9 }' | sed -e 's/.*,//g' | sed -e 's/.*=//g' | sed -e 's/|//'); do
	if ping -c 1 -W 1 "$server" > /dev/null 2>&1 ; then 
		echo "$(date) $server is OK"
	else 
		echo "$(date) $server is DOWN";
	
		server_name=$(openstack server list | grep "$server" | awk '{print $4}')

		if [ -n "$server_name" ]; then 
			echo "$(date) Starting: $server_name ..." 
			openstack server start "$server_name"
			
			if [ "$server_name" = "db1" ]; then
				echo "$(date) Restarting yugaDB on $server_name ..."	
				sleep 60
				ssh ubuntu@$server \
					"cd /home/ubuntu/yugabyte-2025.2.0.0 && sudo ./bin/yugabyted start --advertise_address=192.168.132.48 --base_dir=/gfdata"
			fi	
		else 
			echo "$(date) ERROR: Could not find server name for $server :("
		fi

	fi


done
