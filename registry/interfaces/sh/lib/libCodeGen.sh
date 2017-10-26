##
## Code generation management library
##
set -e

##
## List known languages
##
function codegenListLanguages {
	find $LIBROOT -mindepth 1 -type d -exec basename {} \; | xargs
}

##
## List known types
##
function codegenListTypes {
	echo "itf"
}

##
## Validate type
## $1: type to be checked
##
function codegenCheckType {
	local typeOK=6
	declare -i typeOK
	for knownType in $(codegenListTypes); do
		if [ "$knownType" == "$1" ]; then
			typeOK=0
		fi
	done
	return $typeOK
}

##
## Generate code main entry point
##
function codegenBuild {
	# Branch to specific generation code
	codegenBuild_itf
}

##
## Generate code for interface file
##
function codegenBuild_itf {
	# Build replacement expression
	local ITFGENREPLACE=(
		"{TOKEN.PACKAGE}|libra.itf"
		"{TOKEN.MAIN.DOC}|$(itfDoc $GENINPUT)"
		"{TOKEN.ITF.NAME}|$(itfName $GENINPUT)"
		"{TOKEN.TOKEN}|$(itfToken $GENINPUT)"
		"{TOKEN.METHODS}|$(codegenBuild_itfMethods)"
	)
	local GENREPLACE=""
	local index
	for index in $(seq 0 4); do
		local tokenExpr=${ITFGENREPLACE[$index]}
		local tokenName="${tokenExpr%%|*}"
		local tokenRepl="${tokenExpr##*|}"
		GENREPLACE="${GENREPLACE}s|$tokenName|$tokenRepl|g;"
	done
	
	# Perform substitutions on template
	cat $TEMPLATE_INTERFACE_FILE | sed -e "$GENREPLACE"
}

##
## Generate methods block code for interface file
##
function codegenBuild_itfMethods {
	# Iterate on methods
	local methodName
	local tmp=$(mktemp)
	local first=1
	touch $tmp
	for methodName in $(itfMethods $GENINPUT); do
		# Build replacement expression (3 tokens)
		local ITFGENREPLACE=(
			"{TOKEN.METHOD.DOC}|$(itfMethodGetDoc $GENINPUT $methodName)"
			"{TOKEN.METHOD.TYPE}|$(itfMethodGetType $GENINPUT $methodName | codegenSpecificGetType)"
			"{TOKEN.METHOD.NAME}|$methodName"
		)
		local GENREPLACE=""
		local index
		for index in $(seq 0 2); do
			local tokenExpr=${ITFGENREPLACE[$index]}
			local tokenName="${tokenExpr%%|*}"
			local tokenRepl="${tokenExpr##*|}"
			GENREPLACE="${GENREPLACE}s|$tokenName|$tokenRepl|g;"
		done
		
		# Perform substitutions on template
		if test $first -eq 0; then
			echo "" >> $tmp
		else
			first=0
		fi
		cat $TEMPLATE_INTERFACE_METHOD_FILE | sed -e "$GENREPLACE" >> $tmp
	done
	
	cat $tmp | sed -e "s/$/\\\\n/g" | tr '\n' ' '
	rm $tmp
}
