##
## Plugin Manager library
##

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
## Read the MANIFEST.MF file and print the required tools
##
## $1: bundle directory
##
function pmGetManifestRequiredTools {
	awk -F': ' '/^Require-Tool: / {print $2}' "$1/META-INF/MANIFEST.MF"
}
