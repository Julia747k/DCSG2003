#!/bin/bash

source /home/ubuntu/base.sh 

#Kjører ls og fjerner eventuelle feilmeldinger fra utskriften
ls $1 >/dev/null 2>&1 
exit_value=$?

if [ $exit_value -eq 0 ]; then 
	info "Exsists"
else 
	error "Does not exsist (error msg: $exit_value)"
fi 	

