#!/bin/bash
#####################################################################
# runme.sh for PKGBUILD file
#
# run the PKGBUILD file
#
# Copyright 2015 Yunhui Fu
# License: GPL v3.0 or later
#####################################################################

ln -s ../arch-kali-rpi2/kali-wifi-injection-3.18.patch
ln -s ../arch-kali-rpi2/librepo.sh
ln -s ../arch-kali-rpi2/mkpkg.sh

DN=$(pwd)

cat << EOF > mymakepkg.conf
PKGDEST=${DN}/pkg
SRCDEST=${DN}/src
SRCPKGDEST=${DN}/repo
EOF

./mkpkg.sh --config mymakepkg.conf -p PKGBUILD --dryrun
./mkpkg.sh --config mymakepkg.conf -p PKGBUILD
