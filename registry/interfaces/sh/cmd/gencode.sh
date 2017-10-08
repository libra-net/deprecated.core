#!/bin/bash

##
## Code generator script
##
set -e
EXE_FILE=$(readlink -f "$0")
CMDROOT=$(dirname "$EXE_FILE")
LIBROOT="$CMDROOT/../lib"
source $LIBROOT/libInterfaces.sh
source $LIBROOT/libCodeGen.sh

##
## Help display
##
function __help {
	echo "NAME
	gencode - Tool to generate code from interface JSON file

USAGE
	gencode [OPTIONS]

OPTIONS
	-h, --help
		Displays this message.
	
	-i|--input <INPUT>
		Input interface JSON file for which to generate code
	
	-l|--language <LANGUAGE>
		Target implementation language for which to generate code
		Allowed values are: $(codegenListLanguages)
	
	-t|--type <TYPE>
		Code type to be generated
		Allowed values are: $(codegenListTypes)
"
}

## Process args
while test -n "$1"; do
	case $1 in
		-h|--help) __help; exit 0;;
		-l|--language) shift; GENLANG="$1";;
		-i|--input) shift; GENINPUT="$1";;
		-t|--type) shift; GENTYPE="$1";;
		*)  ;;
	esac
	shift
done

## Verify language
if test -z "$GENLANG"; then
	echo Language is not specified >&2
	exit 1
fi
GENROOT=$LIBROOT/$GENLANG
GENLIB=$GENROOT/libCodeGen-$GENLANG.sh
if test ! -f $GENLIB; then
	echo Unknown language: $GENLANG >&2
	exit 2
fi
source $GENLIB

## Verify input
if test -z "$GENINPUT"; then
	echo Input interface file is not specified >&2
	exit 3
fi
if test ! -f "$GENINPUT"; then
	echo Input interface file not found: $GENINPUT >&2
	exit 4
fi
itfValidate $GENINPUT

## Verify type
if test -z "$GENTYPE"; then
	echo Generated code type is not specified >&2
	exit 5
fi
codegenCheckType $GENTYPE

## Ready for generation
#GENOUTPUT="$(codegenBuild)"
codegenBuild

## Default: display generated code
#echo $GENOUTPUT
