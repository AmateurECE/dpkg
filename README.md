# Packages for `dpkg`

This repository contains metadata for packaging certain tools and libraries
under `dpkg`, providing installation candidates for Debian-based distributions.

# Building Packages

## Cloning a Source Package from Somewhere Other Than GitHub

The `git-archive(1)` tool provides a useful mechanism for creating a source
package of a git repository from a certain tree. Unfortunately, for most
open-source non-owned repositories, this still requires cloning first, since
using the tool with a remote repository usually requires SSH access (in the
case of Gitlab).

The following creates a source package for packaging with `dpkg` from a
checkout of the Pacman sources in the current directory.

```
git archive --format=tar.gz --prefix=pacman-6.0.1/ \
        -o ../dpkg/pacman_6.0.1.orig.tar.gz refs/tags/v6.0.1
```

## Cloning a Source Package from GitHub

GitHub doesn't support `git-archive(1)`, but does have another means to
download sources for packaging. Simply append `/archive/$tag.tar.gz` to get a
tarball, where `$tag` is the revision. This works with any valid Git object.
