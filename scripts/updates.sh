#!/bin/bash
source /home/ubuntu/base.sh

# IMPORTANT: first file is the change one, second is the one in /home/ubuntu/{filename}

update_file(){
	if equal "$1" "$2"; then
    		info "Nothing to update!"
    		return 0
	else
		# captures equal() exit code
		status=$? 
		case $status in
        		1) cp "$1" "$2"; ok "Updated $2"; return 1;;
        		2) echo "One of the files doesn't exist!" ; return 2;;
			*) error "Unexpected status from equal()" ;return 99;;
		esac
	fi
}

#updates all scripts in /home/ubuntu/base.sh/
update_scripts(){
	for file in ~/DCSG2003/scripts/*; do
    		filename=$(basename "$file")
    		update_file "$file" "/home/ubuntu/$filename"
	done

}
