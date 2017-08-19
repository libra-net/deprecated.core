##
## Plugin Manager library
##
set -e

##
## Read the .project file and print Eclipse project name
##
## $1: bundle directory
##
function pmGetEclipseProjectName {
	xmlstarlet sel -t -m '//projectDescription/name' -v 'text()' "$1/.project"
}

##
## Read the MANIFEST.MF file and print the bundle name
##
## $1: bundle directory
##
function pmGetManifestSymbolicName {
	awk -F': ' '/^Bundle-SymbolicName: / {print $2}' "$1/META-INF/MANIFEST.MF"
}

##
## Read the MANIFEST.MF file and print the bundle vendor
##
## $1: bundle directory
##
function pmGetManifestVendor {
	awk -F': ' '/^Bundle-Vendor: / {print $2}' "$1/META-INF/MANIFEST.MF"
}

##
## Read the MANIFEST.MF file and print the required tools (list)
##
## $1: bundle directory
##
function pmGetManifestRequiredTools {
	awk -F': ' '/^Require-Tool: / {print $2}' "$1/META-INF/MANIFEST.MF" > /tmp/$$
	cat /tmp/$$ | sed -e "s|,| |g"
}

##
## Get all bundle directories for the running program (list)
##
## $1: root directory for running program
##
function pmGetAllBundleDirs {
	find "$1" -name META-INF | xargs | sed -e "s|/META-INF||g"
}

##
## Verify if required tool is present on the system
##
## $1: required tool
##
function pmCheckTool {
	which "$1" > /dev/null || (echo "Required command ($1) is not installed on the system." >&2; false)
}