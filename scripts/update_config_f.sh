#!/bin/bash

source /home/ubuntu/base.sh

#GET IP OF WEB SERVERS AND UPDATES CONFIG FILE
for server in $(openstack server list | grep Ubu | grep -v manager | sed -n '/\bwww[12]\b/p' | awk '{ print $8 $9 }' | sed -e 's/.*,//g' | sed -e 's/.*=//g' | sed -e 's/|//'); do
        	
	ssh root@$server "uc store get bf/config > /var/www/html/config.json"
	if [ $? -eq 0 ]; then
    		info "Config updated on $server"
	else
    		error "FAILED to update on $server (exit code $?)"
fi
done

