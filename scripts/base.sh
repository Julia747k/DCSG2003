RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info () {
echo -e "${CYAN}$1${NC}"
}

error () {
echo -e "${RED}$1${NC}"
}

warn () {
echo -e "${YELLOW}$1${NC}"
}

ok () {
echo -e "${GREEN}$1${NC}"
}


# Compares two files by checksum:
# returns 0 if files exist and are identical
# returns 1 if files exist but differ
# returns 2 if one or both files are missing
equal( ){
    local f1="$1"
    local f2="$2"

    [[ -e "$f1" && -e "$f2" ]] || return 2

    local c1 c2
    c1=$(sha256sum "$f1" | awk '{print $1}')
    c2=$(sha256sum "$f2" | awk '{print $1}')

    [[ "$c1" == "$c2" ]]
}

#handles errors 
handle_error(){
	if [ $? -ne 0 ]; then
		echo "Error: the exit value is not 0, something failed"
		exit 1
	fi
}

