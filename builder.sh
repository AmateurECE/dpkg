#!/bin/bash
###############################################################################
# NAME:             builder.sh
#
# AUTHOR:           Ethan D. Twardy <ethan.twardy@gmail.com>
#
# DESCRIPTION:      This useful utility script clones the source for a package
#                   and builds it.
#
# CREATED:          05/25/2022
#
# LAST EDITED:      05/25/2022
###

set -e

ERROR_MESSAGE="\
Error. This script must be run from a folder containing a debian/ folder\
"

if [[ ! -d debian ]]; then
    >&2 printf '%s\n' "$ERROR_MESSAGE"
    exit 1
fi

fullname=$(basename $PWD)
package=${fullname%%-*}
version=${fullname##*-}

# Get a .tar.gz of the source at the tag
curl -L -O https://github.com/AmateurECE/$package/archive/v$version.tar.gz

# Unzip it into the current directory
tar xzvf v$version.tar.gz -C ..

# Move the source into the parent directory (used by debuild)
mv v$version.tar.gz ../${package}_${version}.orig.tar.gz

# Build the package
debuild -us -uc

###############################################################################
