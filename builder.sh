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
# LAST EDITED:      09/22/2022
###

set -e

# If the source resides on GitHub, we have to clone it in a special way.
get_github_source() {
    repository=${1%%.git}

    # Get a .tar.gz of the source at the tag
    printf '%s\n' "Downloading $repository/archive/v$version.tar.gz"
    curl -L -O $repository/archive/v$version.tar.gz

    # Unzip it into the current directory
    tar xzvf v$version.tar.gz -C ..

    # Move the source into the parent directory (used by debuild)
    mv v$version.tar.gz ../${package}_${version}.orig.tar.gz
}

get_git_source() {
    >&2 printf '%s\n' "Unimplemented: get_git_source"
    exit 1
}

ERROR_MESSAGE="\
Error. This script must be run from a folder containing a debian/ folder\
"

if [[ ! -d debian ]]; then
    >&2 printf '%s\n' "$ERROR_MESSAGE"
    exit 1
fi

fullname=$(basename $PWD)
package=${fullname%-*}
version=${fullname##*-}

# Get the git repo
repository_url=$(awk '/^Vcs-Git/{print $2}' debian/control)
if [[ $repository_url =~ "github.com" ]]; then
    get_github_source $repository_url
else
    get_git_source $repository_url
fi

# If we just want to download the artifacts, stop here.
if [[ "1" = ${DOWNLOAD_ONLY:-0} ]]; then
    exit 0
fi

# Build the package
debuild -us -uc

###############################################################################
