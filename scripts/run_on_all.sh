#!/bin/bash

COMMAND=$1

for server in $(openstack server list | grep Ubu | grep -v manager | awk '{ print $8 $9 }' | sed -e 's/.*,//g' | sed -e 's/.*=//g' | sed -e 's/|//'); do
  # Print out the IP of the server
  echo "server: $server";

  # run the command in question
  ssh root@$server $COMMAND ;

done


