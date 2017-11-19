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
## Validate if the required string is a known type for the input json file
##
## $1: json interface file
## $2: type name
## $3: (Optional) error message
##
function itfValidateType {
	itfValidate $1
	
	# Check type
	local ret
	case $2 in
		void|string)
			ret=0 ;;
		*)
			ret=1
			local msg="Unknown type: $2"
			if [ "$3" != "" ]; then msg="$3"; fi
			echo "$msg" >&2 ;;
	esac
	return $ret
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
## Get main documentation from input json file
##
## $1: json interface file
##
function itfDoc {
	itfValidate $1
	local tmp=$(mktemp)
	jq -c ".doc" $1 > $tmp
	cat $tmp | sed -e 's|"\(.*\)"|\1|'
	rm -f $tmp
}

##
## Get name from input json file
##
## $1: json interface file
##
function itfName {
	itfValidate $1
	local tmp=$(mktemp)
	basename --suffix=.json $1 > $tmp
	name=$(cat $tmp)
	echo ${name^}
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

##
## Get required method return type from input json file
##
## $1: json interface file
## $2: method name
##
function itfMethodGetType {
	itfValidate $1
	local tmp=$(mktemp)
	jq -c ".methods[] | select(.name == \"$2\") | .ret" $1 > $tmp
	local ret=$(cat $tmp | xargs)
	rm -f $tmp
	if [ "$ret" == "" ]; then echo "Unknown method: $2" >&2; return 1; fi
	if [ "$ret" == "null" ]; then ret=void; fi
	itfValidateType $1 $ret "Unknown return type for method $2: $ret"
	echo $ret
}

##
## Get required method doc from input json file
##
## $1: json interface file
## $2: method name
##
function itfMethodGetDoc {
	itfValidate $1
	local tmp=$(mktemp)
	jq -c ".methods[] | select(.name == \"$2\") | .doc" $1 > $tmp
	local doc=$(cat $tmp | sed -e 's|"\(.*\)"|\1|')
	rm -f $tmp
	if [ "$doc" == "" ]; then echo "Unknown method: $2" >&2; return 1; fi
	echo $doc
}

##
## Get required method arg names from input json file
##
## $1: json interface file
## $2: method name
##
function itfMethodGetArgs {
	itfValidate $1
	local tmp=$(mktemp)
	jq -c ".methods[] | select(.name == \"$2\") | .args" $1 > $tmp
	if [ "$(cat $tmp)" == "null" ]; then
		local args=""
	else
		jq -c ".methods[] | select(.name == \"$2\") | .args[] | .name" $1 > $tmp
		local args=$(cat $tmp | sed -e 's|"\(.*\)"|\1|g' | xargs)
		rm -f $tmp
		if [ "$args" == "" ]; then echo "Unknown method: $2" >&2; return 1; fi
	fi
	echo $args
}

##
## Get type name for required method arg name from input json file
##
## $1: json interface file
## $2: method name
## $3: arg name
##
function itfMethodGetArgType {
	local args=$(itfMethodGetArgs $1 $2)
	if [ "$args" == "" ]; then echo "Method has no args: $2" >&2; return 1; fi
	local tmp=$(mktemp)
	jq -c ".methods[] | select(.name == \"$2\") | .args[] | select(.name == \"$3\")" $1 > $tmp
	local foundArg=$(cat $tmp)
	if [ "$foundArg" == "" ]; then echo "Method $2 has no arg named $3" >&2; return 1; fi
	jq -c ".methods[] | select(.name == \"$2\") | .args[] | select(.name == \"$3\") | .type" $1 > $tmp
	cat $tmp | sed -e 's|"\(.*\)"|\1|'
	rm -f $tmp
}