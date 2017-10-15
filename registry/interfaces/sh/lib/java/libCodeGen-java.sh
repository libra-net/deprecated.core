##
## Code generation management library (Java implementation)
##
## GENROOT variable points to this language specific resources directory
##
set -e

# Set Template files for Java
TEMPLATE_INTERFACE_FILE=$GENROOT/InterfaceTemplate.java
TEMPLATE_INTERFACE_METHOD_FILE=$GENROOT/InterfaceMethodTemplate.java

##
## Convert type to Java type
## $1: type to be converted; if no args, read from stdin
##
function codegenSpecificGetType {
	if [ "$1" == "" ]; then
		type=$(cat)
	else
		type=$1
	fi
	case $type in
		string)
			echo "String" ;;
		*)
			# No specific conversion, keep as is
			echo $type ;;
	esac
}

##
## Get sub folder (= Java package) for code generation
##
function codegenGetSubFolder {
	echo "libra/itf"
}

##
## Get file name for code generation
##
function codegenGetFileName {
	echo "$(itfName $GENINPUT).java"
}
