##
## Interfaces handling library
##
set -e

##
## Validate if the input json file is a valid interface file
##
## $1: json interface file
##
function itfValidate {
	# Simple filter to validate JSON syntax
	jq -c . $1 > /dev/null
}

##
## Reckon token from input json file
##
## $1: json interface file
##
function itfToken {
	itfValidate $1
	local tmp=$(mktemp)
	jq -c ".methods[] | del(.doc)" $1 > $tmp
	cat $tmp | md5sum | awk '{print $1}'
	rm -f $tmp
}

##
## Get method names from input json file
##
## $1: json interface file
##
function itfMethods {
	itfValidate $1
	local tmp=$(mktemp)
	jq -c ".methods[] | .name" $1 > $tmp
	cat $tmp | xargs
	rm -f $tmp
}
