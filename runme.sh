#!/bin/bash
#####################################################################
# runme.sh for PKGBUILD file
#
# run the PKGBUILD file
#
# Copyright 2015 Yunhui Fu
# License: GPL v3.0 or later
#####################################################################

DN=$(pwd)

EXEC_MKPKG="${DN}/makepkg.sh"

#export GIT_SSL_NO_VERIFY=true

check_install_tool() {
    if [ ! -x "${EXEC_MKPKG}" ]; then
        git clone https://github.com/yhfudev/bash-fakemakepkg.git "${DN}/fakemakepkg-git"
        EXEC_MKPKG="${DN}/fakemakepkg-git/makepkg.sh"
    fi
    if [ ! -x "${EXEC_MKPKG}" ]; then
        echo "error to get makepkg"
        exit 1
    fi
    ( cd "${DN}/fakemakepkg-git" && git pull )
}

check_install_tool

cat << EOF > "${DN}/mymakepkg.conf"
PKGDEST=${DN}/pkg
SRCDEST=${DN}/src
SRCPKGDEST=${DN}/repo
EOF

${EXEC_MKPKG} --config "${DN}/mymakepkg.conf" -p "${DN}/PKGBUILD" --dryrun
if [ ! "$?" = "0" ]; then
    echo "error in checking the script!"
    exit 1
fi
${EXEC_MKPKG} --config "${DN}/mymakepkg.conf" -p "${DN}/PKGBUILD"
