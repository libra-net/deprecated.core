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
