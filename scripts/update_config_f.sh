#!/bin/bash

source /home/ubuntu/DCSG2003_V26_group37-openrc.sh
source /home/ubuntu/base.sh

#GET IP OF WEB SERVERS AND UPDATES CONFIG FILE
for server in $(openstack server list | grep Ubu | grep -v manager | sed -n '/\bwww[12]\b/p' | awk '{ print $8 $9 }' | sed -e 's/.*,//g' | sed -e 's/.*=//g' | sed -e 's/|//'); do
        
	#Added protection against kyrre slette config.json tull
	ssh root@$server "
		uc store get bf/config > /var/www/html/config.json 2>/dev/null &&
	       	uc store get bf/config > /home/ubuntu/not_configjson_file.json 2>/dev/null
		" || error "[$(date)] Update failed on $server (exit $?)"	
		rc=$?

	if [ $rc -eq 0 ]; then
		info "[$(date)] Config updated on $server "
	else
		error "[$(date)] FAILED to update on $server (exit code $rc)"
fi
done


