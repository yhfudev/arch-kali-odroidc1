#!/usr/bin/env bash
# Maintainer: Yunhui Fu <yhfudev at gmail dot com>

pkgname=kali-odroidc1-image
pkgver=1.1.0
pkgrel=1
pkgdesc="Odroid C1 Kali image"
arch=('i686' 'x86_64' 'arm')
url="https://github.com/yhfudev/arch-kali-odroidc1.git"
license=('GPL')

optdepends=(
    'pixz'
    'bmap-tools'
    'bsdtar'
    )

makedepends=(
    'git' 'bc' 'gcc-libs' 'bash' 'sudo'
    'ncurses' 'lzop' 'uboot-tools' # for kernel
    'qemu' 'qemu-user-static-exp' 'binfmt-support' # cross compile and chroot
    'debootstrap' # to create debian rootfs
    'parted' 'dosfstools'
    'yaourt' 'multipath-tools' # for kpartx, in AUR, you need to use yaourt to install it
    'lib32-libstdc++5' 'lib32-zlib' # for 32 bit compiler
    'base-devel' 'abs' 'fakeroot'
    # 'kernel-package' # debian packages, include make-kpkg
    )
#install="$pkgname.install"
#PKGEXT=.pkg.tar.xz

provides=('kali-odroidc1-git')
conflicts=('kali-odroidc1')

# config for Odroid C1
ARCHITECTURE="armhf"
PATCH_MAC80211="kali-arm-build-scripts-git/patches/kali-wifi-injection-3.12.patch"
CONFIG_KERNEL="odroidc1-3.10.config"
PATCH_CONFIG_KERNEL="odroidc1-kernel-config.patch"
MAKE_CONFIG=odroidc_defconfig

# Package installations for various sections.
# This will build a minimal XFCE Kali system with the top 10 tools.
# This is the section to edit if you would like to add more packages.
# See http://www.kali.org/new/kali-linux-metapackages/ for meta packages you can
# use. You can also install packages, using just the package name, but keep in
# mind that not all packages work on ARM! If you specify one of those, the
# script will throw an error, but will still continue on, and create an unusable
# image, keep that in mind.
PACKAGES_ARM="abootimg cgpt fake-hwclock ntpdate vboot-utils vboot-kernel-utils uboot-mkimage"
PACKAGES_BASE="kali-menu kali-defaults initramfs-tools sudo parted e2fsprogs usbutils nfs-common lsb-release ntfs-3g usbmount hdparm tmux"
PACKAGES_DESKTOP="xfce4 network-manager network-manager-gnome xserver-xorg-video-fbdev"
PACKAGES_TOOLS="passing-the-hash winexe aircrack-ng hydra john sqlmap wireshark libnfc-bin mfoc nmap ethtool"
PACKAGES_SERVICES="openssh-server apache2"
PACKAGES_EXTRAS="iceweasel wpasupplicant"
#PACKAGES_ADDON="fruitywifi xfce4-goodies kali-linux-full"
export PACKAGES="${PACKAGES_ARM} ${PACKAGES_BASE} ${PACKAGES_DESKTOP} ${PACKAGES_TOOLS} ${PACKAGES_SERVICES} ${PACKAGES_EXTRAS} ${PACKAGES_ADDON}"

# the image container size
IMGCONTAINER_SIZE=3000 # Size of image in megabytes
#IMGCONTAINER_SIZE=7000 # MB, size of kali-linux-full

# If you have your own preferred mirrors, set them here.
# You may want to leave security.kali.org alone, but if you trust your local
# mirror, feel free to change this as well.
# After generating the rootfs, we set the sources.list to the default settings.
export INSTALL_MIRROR=http.kali.org
export INSTALL_SECURITY=security.kali.org

# the /boot path for u-boot
MNTPOINT_BOOT_FIRMWARE=/boot/firmware/
# the root fs / label
DISKLABEL_ROOTFS=rootfs
# the /boot fs label
DISKLABEL_BOOTFS=BOOTFS


DNSRC_UBOOT_HARDKERNEL=uboot-hardkernel-git
GITCOMMIT_UBOOT_HARDKERNEL=f631c80969b33b796d2d4c077428b4765393ed2b
 
GITCOMMIT_LINUX=c193f5d80656ce6d471cf3a28fe8259b3e3a02c0
#GITCOMMIT_LINUX=98b7d2c2c9da3d43d42adce240edef98c3c50a43
GITCOMMIT_UBOOT=${GITCOMMIT_UBOOT_HARDKERNEL}
DNSRC_LINUX=linux-${GITCOMMIT_LINUX}
DNSRC_UBOOT=u-boot-${GITCOMMIT_UBOOT}
USE_GIT_REPO=0
#DNSRC_UBOOT=${DNSRC_UBOOT_HARDKERNEL}
#DNSRC_LINUX=linux-hardkernel-git

source=(
        "kali-arm-build-scripts-git::git+https://github.com/offensive-security/kali-arm-build-scripts.git"
        "https://github.com/hardkernel/linux/archive/${GITCOMMIT_LINUX}.tar.gz" # "${DNSRC_LINUX}::git+https://github.com/hardkernel/linux.git"
        "http://dn.odroid.com/toolchains/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.xz" #http://releases.linaro.org/14.09/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.xz
        "firmware-linux-git::git+https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
        "odroidc1-3.10.config"
        "odroidc1-kernel-config.patch"
        "kali-wifi-injection-chan.c.patch" # patch for net/wireless/chan.c from kali-arm-build-scripts-git/patches/kali-wifi-injection-3.18.patch

        # u-boot
        "https://github.com/hardkernel/u-boot/archive/${GITCOMMIT_UBOOT_HARDKERNEL}.tar.gz" # "${DNSRC_UBOOT_HARDKERNEL}::git+https://github.com/hardkernel/u-boot.git"
        "http://dn.odroid.com/toolchains/gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz"
        "boot.ini.template"
        "sd_fusing.sh"

        "odroid-utility-git::git+https://github.com/mdrjr/odroid-utility.git"
        "debian-systemstart.sh"
        "debian-zram.sh"
        "bash.bashrc.template"
        )

md5sums=(
         'SKIP' # kali-arm-build-scripts-git
         'SKIP' # linux
         'd7805745171f63c2556083e20abbd8eb' # gcc for kernel
         'SKIP' # firmware-linux-git
         'e54725fa965b4b8531563f40a420a40c' # odroidc1-3.10.config
         '3006f3b72f678f2a1ea707b16e0cc8f5' # odroidc1-kernel-config.patch
         '7e52e713f85591ee8b1cf43474da4425' # kali-wifi-injection-chan.c.patch
         'SKIP' # u-boot
         '12d6e8a0cbd2d8e130cc8f55389a95c3' # gcc for uboot
         '5dc37b921aef0877a1b32f741c27571b' # boot.ini.template
         'bb60369d23ba492e41524c9338f678c1' # sd_fusing.sh
         'SKIP' # odroid-utility-git
         'f488b18bc2ab3bfda4efda2b8f5f773b' # debian-systemstart.sh
         '3793439a6f13115f2251e782646ee8e6' # debian-zram.sh
         '669e17ce329f97c88f49d55a57d9546f' # bash.bashrc.template
         )
sha1sums=(
         'SKIP' # kali-arm-build-scripts-git
         'SKIP' # linux
         'b6d5f985ac254b1d60d8f01459f64d248adb7838' # gcc for kernel
         'SKIP' # firmware-linux-git
         '95cb733d04afb2960beb7c4f5090ca47b943c8d0' # odroidc1-3.10.config
         '26b87b084b894934851af9560af600c628b115ac' # odroidc1-kernel-config.patch
         '84538b4eed140aa186e9fa9af38db08f07c0af14' # kali-wifi-injection-chan.c.patch
         'SKIP' # u-boot
         '8069f484cfd5a7ea02d5bb74b56ae6c99e478d13' # gcc for uboot
         '2cba8b991d841f773123debc9a4ab43b7a422f04' # boot.ini.template
         '79af8ab465eeb371e83b0b3670869f087040080b' # sd_fusing.sh
         'SKIP' # odroid-utility-git
         '37f7c678e300b433aa2f0319f63065784dd056da' # debian-systemstart.sh
         'ab5a6304d3e3ca5b315cff0bfa25558e38520100' # debian-zram.sh
         'db80fedf2e3a102d3d6deca56afd529c04bf938d' # bash.bashrc.template
         )

pkgver() {
    cd "${srcdir}/kali-arm-build-scripts-git"
    local ver="$(git show | grep commit | awk '{print $2}'  )"
    #printf "r%s" "${ver//[[:alpha:]]}"
    echo ${ver:0:7}
}

PREFIX_TMP="${srcdir}/tmptmp-${pkgname}"

FORMAT_NAME='arm'
FORMAT_MAGIC='\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00'
FORMAT_MASK='\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff'
FORMAT_INTERP='/usr/bin/qemu-arm-static'
FORMAT_REGISTRATION=":$FORMAT_NAME:M::$FORMAT_MAGIC:$FORMAT_MASK:$FORMAT_INTERP:"
BINFMT_MISC="/proc/sys/fs/binfmt_misc"

register_qemuarm() {
    # Check if format is not registered already
    if [ ! -f "$BINFMT_MISC/$FORMAT_NAME" ]; then
        echo "Registering arm binfmt_misc support"
        echo "echo '$FORMAT_REGISTRATION' > /proc/sys/fs/binfmt_misc/register" | sudo sh
    else
        echo "Format $FORMAT_NAME already registered."
    fi
}

unregister_qemuarm() {
    # We were asked to drop the registration
    if [ -f "$BINFMT_MISC/$FORMAT_NAME" ]; then
        echo "echo -1 > '$BINFMT_MISC/$FORMAT_NAME'" | sudo sh
    else
        echo "Format $FORMAT_NAME not registered."
    fi
}

# since the apt-get place lock in $ROOTFS/var/cache/apt/archives
# we need to seperate the dir from multiple instances if we want to share the apt cache
# so we place *.deb and lock file into two folders in ${SRCDEST}/apt-cache-armhf and ${srcdir}/apt-cache-armhf seperately

# link the *.deb from ${SRCDEST}/apt-cache-armhf to ${srcdir}/apt-cache-armhf
aptcache_link2srcdst() {
    # the dir stores the real files
    PARAM_DN_BASE=$1
    shift
    # the dir contains the symbol links
    PARAM_DN_LINK=$1
    shift

    cd "${PARAM_DN_LINK}"
    find "${PARAM_DN_BASE}" -name "*.deb" -type f | while read i; do
        FN="$(basename ${i})"
        sudo rm -f "${FN}"
        sudo ln -s "${i}" "${FN}"
    done
    cd -
}

# backup the new downloaded *.deb from ${srcdir}/apt-cache-armhf to ${SRCDEST}/apt-cache-armhf
aptcache_backup2srcdst() {
    # the dir stores the real files
    PARAM_DN_BASE=$1
    shift
    # the dir contains the symbol links
    PARAM_DN_LINK=$1
    shift

    # make sure the files are not symbol links
    cd "${PARAM_DN_LINK}"
    find "${PARAM_DN_LINK}" -name "*.deb" -type f | while read i; do
        FN="$(basename ${i})"
        sudo mv "${i}" "${PARAM_DN_BASE}"
        sudo rm -f "${FN}"
        sudo ln -s "${PARAM_DN_BASE}/${FN}" "${FN}"
    done
    cd -
}

kali_rootfs_debootstrap() {
    PARAM_DN_DEBIAN=$1
    shift
    PARAM_DN_RPI=$1
    shift

    # the apt cache folder
    DN_APT_CACHE="${SRCDEST}/apt-cache-kali-${MACHINEARCH}"
    mkdir -p "${DN_APT_CACHE}"

    # build kali rootfs
    cd "$srcdir"

    if [ ! -f /usr/share/debootstrap/scripts/kali-current ]; then
        sudo ln -s /usr/share/debootstrap/scripts/sid /usr/share/debootstrap/scripts/kali-current
    fi
    if [ ! -f /usr/share/debootstrap/scripts/kali-current ]; then
        echo "Error: no debootstrap for kali"
        exit 1
    fi

    if [ "${ISCROSS}" = "1" ]; then
        register_qemuarm
    fi

    sudo mkdir -p "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives"
    sudo mkdir -p "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives-real"
    sudo mount -o bind "${DN_APT_CACHE}" "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives-real/"
    aptcache_link2srcdst "../archives-real/" "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives"

    echo "[DBG] debootstrap stage 1"
    if [ -f "${PREFIX_TMP}-FLG_KALI_ROOTFS_STAGE1" ]; then
        echo "[DBG] SKIP debootstrap stage 1"

    else
        # create the rootfs - not much to modify here, except maybe the hostname.
        echo "[DBG] debootstrap --foreign --arch ${MACHINEARCH} kali-current '${DN_ROOTFS_DEBIAN}'  http://${INSTALL_MIRROR}/kali"
        sudo debootstrap --foreign --no-check-gpg --include=ca-certificates,ssh,vim,locales,ntpdate,initramfs-tools --arch ${MACHINEARCH} kali-current "${DN_ROOTFS_DEBIAN}" "http://${INSTALL_MIRROR}/kali"
        if [ "$?" = "0" ]; then
            touch "${PREFIX_TMP}-FLG_KALI_ROOTFS_STAGE1"
        else
            echo "Error in debootstrap stage 1"
            exit 1
        fi
    fi

    if [ "${ISCROSS}" = "1" ]; then
        sudo cp `which qemu-arm-static` "${DN_ROOTFS_DEBIAN}/usr/bin/"
    fi

    echo "[DBG] debootstrap stage 2"
    if [ -f "${PREFIX_TMP}-FLG_KALI_ROOTFS_STAGE2" ]; then
        echo "[DBG] SKIP debootstrap stage 2"

    else
        sudo chroot "${DN_ROOTFS_DEBIAN}" /usr/bin/env -i LANG=C /debootstrap/debootstrap --second-stage
        if [ "$?" = "0" ]; then
            touch "${PREFIX_TMP}-FLG_KALI_ROOTFS_STAGE2"
        else
            echo "Error in debootstrap stage 2"
            exit 1
        fi
    fi

    echo "[DBG] debootstrap stage 2.5"
    sudo rm -f "${DN_ROOTFS_DEBIAN}/etc/hostname"
    sudo rm -f ${DN_ROOTFS_DEBIAN}/etc/ssh/ssh_host_*

    # Create sources.list
    cat << EOF > "${PREFIX_TMP}-aptlst1"
deb http://${INSTALL_MIRROR}/kali kali-current main contrib non-free
deb http://${INSTALL_SECURITY}/kali-security kali-current/updates main contrib non-free
EOF
    chmod 644 "${PREFIX_TMP}-aptlst1"
    sudo chown root:root "${PREFIX_TMP}-aptlst1"
    sudo mv "${PREFIX_TMP}-aptlst1" "${DN_ROOTFS_DEBIAN}/etc/apt/sources.list"
    if [ ! "$?" = "0" ]; then
        echo "Error in move apt/sources.list 2.5"
        exit 1
    fi

    # Set hostname
    #echo "echo kali > '${DN_ROOTFS_DEBIAN}/etc/hostname'" | sudo sh

    # So X doesn't complain, we add kali to hosts
    cat << EOF > "${PREFIX_TMP}-host"
127.0.0.1       kali    localhost
::1             localhost ip6-localhost ip6-loopback
fe00::0         ip6-localnet
ff00::0         ip6-mcastprefix
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters
EOF
    chmod 644 "${PREFIX_TMP}-host"
    sudo chown root:root "${PREFIX_TMP}-host"
    sudo mv "${PREFIX_TMP}-host" "${DN_ROOTFS_DEBIAN}/etc/hosts"
    if [ ! "$?" = "0" ]; then
        echo "Error in move hosts"
        exit 1
    fi

    cat << EOF > "${PREFIX_TMP}-net"
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF
    sudo mv "${PREFIX_TMP}-net" "${DN_ROOTFS_DEBIAN}/etc/network/interfaces"

    cat << EOF > "${PREFIX_TMP}-reso"
nameserver 8.8.8.8
EOF
    chmod 644 "${PREFIX_TMP}-reso"
    sudo chown root:root "${PREFIX_TMP}-reso"
    sudo mv "${PREFIX_TMP}-reso" "${DN_ROOTFS_DEBIAN}/etc/resolv.conf"
    if [ ! "$?" = "0" ]; then
        echo "Error in move resolv.conf"
        exit 1
    fi

    export MALLOC_CHECK_=0 # workaround for LP: #520465
    export LC_ALL=C
    export DEBIAN_FRONTEND=noninteractive

    cat << EOF > "${PREFIX_TMP}-deb"
console-common console-data/keymap/policy select Select keymap from full list
console-common console-data/keymap/full select en-latin1-nodeadkeys
EOF
    chmod 644 "${PREFIX_TMP}-deb"
    sudo chown root:root "${PREFIX_TMP}-deb"
    sudo mv "${PREFIX_TMP}-deb" "${DN_ROOTFS_DEBIAN}/debconf.set"
    if [ ! "$?" = "0" ]; then
        echo "Error in move script debconf.set"
        exit 1
    fi

cat << EOF > "${PREFIX_TMP}-fstab"
LABEL=${DISKLABEL_ROOTFS}   /           auto    defaults,noatime,data=writeback,errors=remount-ro  0       1
LABEL=${DISKLABEL_BOOTFS}   ${MNTPOINT_BOOT_FIRMWARE}  auto    defaults,ro,owner,flush,umask=000        0       2

tmpfs       /tmp        tmpfs   nodev,nosuid,mode=1777,size=10%         0   0
#tmpfs       /tmp        tmpfs   nodev,nosuid,mode=1777,size=100m,noatime 0   0
tmpfs       /var/tmp    tmpfs   defaults,noatime,nosuid,size=30m        0   0

#tmpfs       /var/log    tmpfs   nodev,nosuid,size=20%,mode=1755     0       0
tmpfs       /var/log    tmpfs   defaults,noatime,nosuid,mode=0755,size=100m 0   0

# /var/run is a link to /run
#tmpfs       /var/run    tmpfs   defaults,noatime,nosuid,mode=0755,size=2m   0   0

proc            /proc       proc    defaults                            0       0
EOF
    chmod 644 "${PREFIX_TMP}-fstab"
    sudo chown root:root "${PREFIX_TMP}-fstab"
    sudo mv "${PREFIX_TMP}-fstab" "${DN_ROOTFS_DEBIAN}/etc/fstab"
    if [ ! "$?" = "0" ]; then
        echo "Error in move etc/fstab"
        exit 1
    fi
    # Stop the boot-sequence whinging about /tmp being read-only before /tmp is mounted:
    touch "${DN_ROOTFS_DEBIAN}/tmp/.tmpfs"

    echo "[DBG] debootstrap stage 3"
    if [ -f "${PREFIX_TMP}-FLG_KALI_ROOTFS_STAGE3" ]; then
        echo "[DBG] SKIP debootstrap stage 3"

    else
        #sudo mkdir -p "${DN_ROOTFS_DEBIAN}/sys"
        #sudo mkdir -p "${DN_ROOTFS_DEBIAN}/proc"
        #sudo mkdir -p "${DN_ROOTFS_DEBIAN}/dev/"
        #sudo mkdir -p "${DN_ROOTFS_DEBIAN}/dev/pts"
        sudo mount -o bind /sys/ "${DN_ROOTFS_DEBIAN}/sys/"
        sudo mount -t proc proc "${DN_ROOTFS_DEBIAN}/proc"
        if [ ! "$?" = "0" ]; then
            echo "Error in mount proc"
            exit 1
        fi
        sudo mount -o bind /dev/ "${DN_ROOTFS_DEBIAN}/dev/"
        if [ ! "$?" = "0" ]; then
            echo "Error in mount dev"
            exit 1
        fi
        sudo mount -o bind /dev/pts "${DN_ROOTFS_DEBIAN}/dev/pts"
        if [ ! "$?" = "0" ]; then
            echo "Error in mount dev/pts"
            exit 1
        fi

        # systemstart
        sudo cp "${srcdir}/debian-systemstart.sh" "${DN_ROOTFS_DEBIAN}/etc/init.d/systemstart"
        sudo cp "${srcdir}/debian-zram.sh" "${DN_ROOTFS_DEBIAN}/etc/init.d/zram"
        if [ ! "$?" = "0" ]; then
            echo "Error in move script systemstart"
            exit 1
        fi

        cat << EOF > "${PREFIX_TMP}-ths"
#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export DEBIAN_FRONTEND=noninteractive

dpkg-divert --add --local --divert /usr/sbin/invoke-rc.d.chroot --rename /usr/sbin/invoke-rc.d
cp /bin/true /usr/sbin/invoke-rc.d
echo -e "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d

apt-get update
apt-get --yes --force-yes install locales-all

debconf-set-selections /debconf.set
rm -f /debconf.set

apt-get update
apt-get --yes --force-yes install git-core binutils ca-certificates initramfs-tools uboot-mkimage
apt-get --yes --force-yes install locales console-common less nano git

sed -i -e "s|^[#\w ]\{1,2\}en_US|en_US|g" /etc/locale.gen
locale-gen en_US en_US.UTF-8 "en_US ISO-8859-1"
update-locale LANG="en_US.UTF-8" LANGUAGE="en_US" LC_ALL="en_US.UTF-8"
#dpkg-reconfigure locales
dpkg-reconfigure -f noninteractive tzdata

echo "root:toor" | chpasswd
#USER1=pi ; useradd -m -s /bin/bash -G adm,sudo,plugdev,audio,video,cdrom,floppy,dip \${USER1} && echo "\${USER1}:\${USER1}" | chpasswd

sed -i -e 's/KERNEL\!=\"eth\*|/KERNEL\!=\"/' /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70-persistent-net.rules
apt-get --yes --force-yes install $PACKAGES

update-rc.d ssh enable

rm -f /usr/sbin/policy-rc.d
rm -f /usr/sbin/invoke-rc.d
dpkg-divert --remove --rename /usr/sbin/invoke-rc.d

sed -i -e 's|^[#\w ]*NEED_STATD[ ]*=.*$|NEED_STATD=yes|' /etc/default/nfs-common
update-rc.d rpcbind enable

# update usbmount
# MOUNTOPTIONS="sync,noexec,nodev,noatime,nodiratime"
sed -i -e 's|MOUNTOPTIONS="|MOUNTOPTIONS="utf8=1,|' /etc/usbmount/usbmount.conf

# tmpfs
sed -i -e 's|^[#\w ]*RAMTMP[ ]*=.*$|RAMTMP=yes|' /etc/default/tmpfs

insserv systemstart
insserv zram

rm -f /third-stage
EOF
        chmod +x "${PREFIX_TMP}-ths"
        sudo mv "${PREFIX_TMP}-ths" "${DN_ROOTFS_DEBIAN}/third-stage"
        if [ ! "$?" = "0" ]; then
            echo "Error in move script third-stage"
            exit 1
        fi

        sudo chroot "${DN_ROOTFS_DEBIAN}" /third-stage
        if [ ! "$?" = "0" ]; then
            echo "Error in third-stage"
            exit 1
        fi

        # unmount the cache folder befor clean up, we may reuse the cache for other builds.
        aptcache_backup2srcdst "../archives-real/" "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives"
        sudo umount "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives-real"
        sudo rmdir "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives-real"
        find "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives/" | while read i ; do sudo rm -rf $i; done

        cat << EOF > "${PREFIX_TMP}-aptlst"
deb http://http.kali.org/kali kali-current main non-free contrib
deb http://security.kali.org/kali-security kali-current/updates main contrib non-free

deb-src http://http.kali.org/kali kali-current main non-free contrib
deb-src http://security.kali.org/kali-security kali-current/updates main contrib non-free
EOF
        chmod 644 "${PREFIX_TMP}-aptlst"
        sudo chown root:root "${PREFIX_TMP}-aptlst"
        sudo mv "${PREFIX_TMP}-aptlst" "${DN_ROOTFS_DEBIAN}/etc/apt/sources.list"
        if [ ! "$?" = "0" ]; then
            echo "Error in move apt/sources.list final: ${DN_ROOTFS_DEBIAN}/etc/apt/sources.list"
            exit 1
        fi

        cat << EOF > "${PREFIX_TMP}-cln"
#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export DEBIAN_FRONTEND=noninteractive
rm -rf /root/.bash_history
apt-get update
apt-get clean
find /var/cache/apt/archives/ | while read i ; do rm -f $i; done
/etc/init.d/dbus stop
/etc/init.d/ssh  stop
rm -f /debconf.set
rm -f /0
rm -f /hs_err*
rm -f /cleanup
rm -f /usr/bin/qemu*
EOF
        chmod +x "${PREFIX_TMP}-cln"
        sudo mv "${PREFIX_TMP}-cln" "${DN_ROOTFS_DEBIAN}/cleanup"
        if [ ! "$?" = "0" ]; then
            echo "Error in move script cleanup"
            exit 1
        fi

        sudo chroot "${DN_ROOTFS_DEBIAN}" /cleanup
        if [ ! "$?" = "0" ]; then
            echo "Error in chroot cleanup"
            exit 1
        fi
        sudo rm -f "${DN_ROOTFS_DEBIAN}/usr/bin/qemu*"
        sudo rm -f "${DN_ROOTFS_DEBIAN}/debconf.set"

        sudo umount "${DN_ROOTFS_DEBIAN}/proc/sys/fs/binfmt_misc"
        #if [ ! "$?" = "0" ]; then
            #echo "Error in unmount proc/sys/fs/binfmt_misc"
            #exit 1
        #fi
        sudo umount "${DN_ROOTFS_DEBIAN}/dev/pts"
        if [ ! "$?" = "0" ]; then
            echo "Error in unmount dev/pts"
            exit 1
        fi
        sudo umount "${DN_ROOTFS_DEBIAN}/dev/"
        if [ ! "$?" = "0" ]; then
            echo "Error in unmount dev"
            exit 1
        fi
        sudo umount "${DN_ROOTFS_DEBIAN}/proc"
        if [ ! "$?" = "0" ]; then
            echo "Error in unmount proc"
            exit 1
        fi
        sudo umount "${DN_ROOTFS_DEBIAN}/sys/"

        #sudo chown -R root:root "${DN_ROOTFS_DEBIAN}"
        touch "${PREFIX_TMP}-FLG_KALI_ROOTFS_STAGE3"
    fi

    # make sure it umounted
    aptcache_backup2srcdst "../archives-real/" "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives"
    sudo umount "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives-real"
    sudo rmdir "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives-real"
    find "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives/" | while read i ; do sudo rm -rf $i; done

    if [ "${ISCROSS}" = "1" ]; then
        unregister_qemuarm
    fi
}

kali_rootfs_linuxkernel() {
    # compile and install linux kernel for Raspberry Pi 2, install rpi2 specified tools

    if [ -f "${PREFIX_TMP}-FLG_KERNEL_COMPILE_CORE" ]; then
        echo "[DBG] SKIP compile kernel core"

    else
        # compile linux kernel for Raspberry Pi 2
        #make clean
        make -j $MACHINECORES
        RET=$?
        if [ ! "${RET}" = "0" ]; then
            echo "compiling linux kernel return $RET"
            echo "Error in compiling linux kernel"
            exit 1
        fi
        make -j $MACHINECORES modules
        if [ ! "$?" = "0" ]; then
            echo "Error in compiling linux kernel modules"
            exit 1
        fi

        my0_check_valid_path "${DN_ROOTFS_KERNEL}"
        sudo chown -R ${USER} "${DN_ROOTFS_KERNEL}"
        # install kernel
        make -j $MACHINECORES modules_install INSTALL_MOD_PATH="${DN_ROOTFS_KERNEL}"
        if [ "$?" = "0" ]; then
            touch "${PREFIX_TMP}-FLG_KERNEL_COMPILE_CORE"
        else
            echo "Error in installing  linux kernel modules"
            exit 1
        fi
    fi

    my0_check_valid_path "${DN_ROOTFS_KERNEL}"
    sudo mkdir -p "${DN_ROOTFS_KERNEL}/lib/"
    sudo rm -rf ${DN_ROOTFS_KERNEL}/lib/firmware
    #git clone --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git ${DN_ROOTFS_KERNEL}/lib/firmware
    sudo cp -r ${srcdir}/firmware-linux-git ${DN_ROOTFS_KERNEL}/lib/firmware
    sudo rm -rf ${DN_ROOTFS_KERNEL}/lib/firmware/.git

if [ 0 = 0 ]; then
    make uImage
    make dtbs
    sudo mkdir -p "${DN_BOOT_4KERNEL}/dtbs/"
    sudo cp arch/arm/boot/uImage "${DN_BOOT_4KERNEL}/"
    sudo cp arch/arm/boot/dts/meson8b_odroidc.dtb "${DN_BOOT_4KERNEL}/dtbs/"

else
    my0_check_valid_path "${DN_ROOTFS_KERNEL}"
    sudo mkdir -p "${DN_BOOT_4KERNEL}"
    sudo chown -R ${USER} "${DN_BOOT_4KERNEL}"
    sudo cp -rf ${srcdir}/firmware-raspberrypi-git/boot/* ${DN_BOOT_4KERNEL}

    sudo cp arch/arm/boot/zImage ${DN_BOOT_4KERNEL}/${FN_RPI_KERNEL}

    T="${PREFIX_TMP}-cmdline.txt"
    cat << EOF > "${T}"
dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 console=tty1 elevator=deadline root=/dev/mmcblk0p2 rootfstype=ext4 rootwait
EOF
    sudo mv "${T}" "${DN_BOOT_4KERNEL}/cmdline.txt"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    # rpi-wiggle
    sudo mkdir -p ${DN_ROOTFS_KERNEL}/scripts
    #sudo wget https://raw.github.com/dweeber/rpiwiggle/master/rpi-wiggle -O ${DN_ROOTFS_KERNEL}/scripts/rpi-wiggle.sh
    sudo cp ${srcdir}/rpiwiggle-git/rpi-wiggle ${DN_ROOTFS_KERNEL}/scripts/rpi-wiggle.sh
    sudo chmod 755 ${DN_ROOTFS_KERNEL}/scripts/rpi-wiggle.sh
fi

}

rsync_and_verify() {
    PARAM_DN_SRC="$1"
    shift
    PARAM_DN_DST="$1"
    shift

    OPTS_OTHER="--devices --specials --acls --xattrs --sparse"

    sudo rsync -HPavz ${OPTS_OTHER} -q "${PARAM_DN_SRC}" "${PARAM_DN_DST}"

if [ 1 = 0 ]; then
    # verify the files
    cd "${PARAM_DN_SRC}/"
    sudo find . -type f | sudo xargs -n 1 md5sum > "${PREFIX_TMP}-md5sum-root"
    cd -
    cd "${PARAM_DN_DST}"
    sudo md5sum -c "${PREFIX_TMP}-md5sum-root"
    RET=$?
    cd -
    if [ "$RET" = "1" ]; then
        # error
        echo "Error in rootfs" >> "${FN_LOG}"
        exit 1
    fi
fi
}

# create a image file with two partitions: /boot/ and /
kali_create_image() {
    PARAM_DN_ROOTFS_DEBIAN="$1"
    shift
    PARAM_DN_ROOTFS_KERNEL="$1"
    shift

    # Create the disk and partition it
    if [[ ! -f "${FN_IMAGE}" || ! -f "${PREFIX_TMP}-FLG_KALI_CREATE_IMAGE" ]]; then
        echo "Creating image file for ${pkgdesc}: ${FN_IMAGE}"
        # check Ubuntu Partition Table http://odroid.com/dokuwiki/doku.php?id=en:c1_partition_table
        sudo rm -f "${FN_IMAGE}"
        dd if=/dev/zero of=${FN_IMAGE} bs=1M count=${IMGCONTAINER_SIZE}
        if [ ! "$?" = "0" ]; then
            echo "error in dd"
            exit 1
        fi
        parted ${FN_IMAGE} --script -- mklabel msdos
        if [ ! "$?" = "0" ]; then
            echo "error in parted"
            exit 1
        fi
        parted ${FN_IMAGE} --script -- mkpart primary fat32   3072s 266239s
        parted ${FN_IMAGE} --script -- mkpart primary ext4  266240s    100%

        install_hardkernel_uboot ${FN_IMAGE}

        touch "${PREFIX_TMP}-FLG_KALI_CREATE_IMAGE"
    else
        echo "[DBG] SKIP creating image file ${FN_IMAGE}"
    fi

if [[ ! -f "${PREFIX_TMP}-FLG_FORMAT_IMAGE" || ! -f "${PREFIX_TMP}-FLG_RSYNC_ROOTFS" || ! -f "${PREFIX_TMP}-FLG_RSYNC_KERNEL" || ! -f "${PREFIX_TMP}-FLG_BSDTAR_ROOTFS" ]]; then
    # Set the partition variables
    DEV_LOOP=$(sudo losetup -f --show ${FN_IMAGE})
    if [ "${DEV_LOOP}" = "" ]; then
        echo "error in losetup"
        exit 1
    fi
    LOOPNAME=$(sudo kpartx -va ${DEV_LOOP} | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1)
    if [ "${LOOPNAME}" = "" ]; then
        echo "Error in loop device"
        exit 1
    fi
    #partprobe "${DEV_LOOP}" # to get /dev/loop0p1 ...
    bootp="/dev/mapper/${LOOPNAME}p1"
    rootp="/dev/mapper/${LOOPNAME}p2"

    echo "waits for 8 seconds for $rootp to be accessible ..."
    sleep 8

    if [ -f "${PREFIX_TMP}-FLG_FORMAT_IMAGE" ]; then
        echo "[DBG] SKIP rsync rootfs"

    else
        echo "Create file systems"
        sudo mkfs.vfat -n ${DISKLABEL_BOOTFS} $bootp
        if [ ! "$?" = "0" ]; then
            echo "error in format boot"
            exit 1
        fi

        # Delete has_journal option
        sudo mkfs.ext4 -F -O ^has_journal -E stride=2,stripe-width=1024 -b 4096 -L ${DISKLABEL_ROOTFS} $rootp
        if [ ! "$?" = "0" ]; then
            echo "error in format root"
            exit 1
        fi

        # enable writeback. this step should do before you use data=writeback in the fstab!
        tune2fs -o journal_data_writeback $rootp

        #dumpe2fs $rootp
        touch "${PREFIX_TMP}-FLG_FORMAT_IMAGE"
    fi

    # Create the dirs for the partitions and mount them
    DN_ROOT="${srcdir}/mntrootfs-${MACHINEARCH}-${pkgname}"
    mkdir -p ${DN_ROOT}
    sudo mount $rootp ${DN_ROOT}
    if [ ! "$?" = "0" ]; then
        echo "error in mount root"
        exit 1
    fi

    DN_BOOT_4IMAGE="${DN_ROOT}${MNTPOINT_BOOT_FIRMWARE}"
    sudo mkdir -p ${DN_BOOT_4IMAGE}
    if [ ! "$?" = "0" ]; then
        echo "error in mkdir ${DN_BOOT_4IMAGE}"
        exit 1
    fi
    sudo mount $bootp ${DN_BOOT_4IMAGE}
    if [ ! "$?" = "0" ]; then
        echo "error in mount boot"
        exit 1
    fi

    if [ -f "${PREFIX_TMP}-FLG_RSYNC_ROOTFS" ]; then
        echo "[DBG] SKIP rsync rootfs"

    else
        echo "Rsyncing rootfs into image file"
        rsync_and_verify "${PARAM_DN_ROOTFS_DEBIAN}/" ${DN_ROOT}/
        touch "${PREFIX_TMP}-FLG_RSYNC_ROOTFS"
    fi

    if [ -f "${PREFIX_TMP}-FLG_RSYNC_KERNEL" ]; then
        echo "[DBG] SKIP rsync rootfs"

    else
        echo "Rsyncing kernel into image file"
        rsync_and_verify "${PARAM_DN_ROOTFS_KERNEL}/" ${DN_ROOT}/
        touch "${PREFIX_TMP}-FLG_RSYNC_KERNEL"
    fi

    if [ -f "${PREFIX_TMP}-FLG_BSDTAR_ROOTFS" ]; then
        echo "[DBG] SKIP bsdtar rootfs"

    else
        echo "tar rootfs from into image file"
        if which bsdtar; then
            # create a tar package for whole system, include /boot and /
            sudo bsdtar -C "${DN_ROOT}" -cf "${FN_IMAGE_BASE}.tar.gz" .
            touch "${PREFIX_TMP}-FLG_BSDTAR_ROOTFS"
        fi
    fi

    # Unmount partitions
    sudo umount ${DN_BOOT_4IMAGE}
    sudo umount ${DN_ROOT}
    sleep 5  # wait umount
    sudo kpartx -dv ${DEV_LOOP}
    sudo losetup -d ${DEV_LOOP}
    if [ ! "$?" = "0" ]; then
        echo "error in losetup"
        exit 1
    fi
fi

    check_kali_image "${FN_IMAGE}"

    # If you're building an image for yourself, comment all of this out, as you
    # don't need the sha1sum or to compress the image, since you will be testing it
    # soon.
    echo "Generating sha1sum for ${FN_IMAGE}"
    if [ ! -f "${FN_IMAGE}.sha1sum" ]; then
        (cd $(dirname ${FN_IMAGE}) && sha1sum $(basename ${FN_IMAGE}) > ${FN_IMAGE}.sha1sum)
    fi
    if [ ! -f "${FN_IMAGE}.bmap" ]; then
        if which bmaptool; then
            bmaptool create -o ${FN_IMAGE}.bmap ${FN_IMAGE}
        fi
    fi
    FLG_COMPRESSED=0
    if [ ! -f "${FN_IMAGE}.xz" ]; then
        if which pixz; then
            # Don't pixz on 32bit, there isn't enough memory to compress the images.
            HW=$(uname -m)
            if [ ${HW} == 'x86_64' ]; then
                echo "Compressing ${FN_IMAGE}"
                pixz ${FN_IMAGE} ${FN_IMAGE}.xz
                if [ "$?" = "0" ]; then
                    rm -f ${FN_IMAGE}
                    echo "Generating sha1sum for ${FN_IMAGE}.xz"
                    (cd $(dirname ${FN_IMAGE}.xz) && sha1sum $(basename ${FN_IMAGE}.xz) > ${FN_IMAGE}.xz.sha1sum)
                    FLG_COMPRESSED=1
                else
                    rm -f ${FN_IMAGE}.xz
                fi
            fi
        fi
    fi
    if [ "${FLG_COMPRESSED}" = "0" ]; then
        gzip -9 -k ${FN_IMAGE}
        if [ "$?" = "0" ]; then
            (cd $(dirname ${FN_IMAGE}.gz) && sha1sum $(basename ${FN_IMAGE}.gz) > ${FN_IMAGE}.gz.sha1sum)
            FLG_COMPRESSED=1
        else
            rm -f ${FN_IMAGE}.gz
        fi
    fi

}

my0_getpath () {
  PARAM_DN="$1"
  shift
  #readlink -f
  DN="${PARAM_DN}"
  FN=
  if [ ! -d "${DN}" ]; then
    FN=$(basename "${DN}")
    DN=$(dirname "${DN}")
  fi
  cd "${DN}" > /dev/null 2>&1
  DN=$(pwd)
  cd - > /dev/null 2>&1
  echo "${DN}/${FN}"
}

my0_check_valid_path() {
    V=$(my0_getpath "$1")
    if [[ "${V}" = "" || "${V}" = "/" ]]; then
        echo "Error: not set path variable: $1"
        exit 1
    fi
}

my_setevn() {
    # setup environments
    MACHINE=${ARCHITECTURE}
    ISCROSS=1
    HW=$(uname -m)
    case ${HW} in
    armv5el)
        # Pi 1
        ISCROSS=0
        MACHINE=armel
        ;;
    armv7l)
        # Pi 2
        ISCROSS=0
        MACHINE=armhf
        ;;
    x86_64)
        ;;
    esac
    export MACHINEARCH="${MACHINE}"

    MACHINECORES=$(grep -c processor /proc/cpuinfo)
    if [ "$MACHINECORES" = "" ]; then
        MACHINECORES=2
    fi

    export FN_IMAGE_BASE="${srcdir}/${pkgname}-${pkgver}-${MACHINEARCH}"
    export FN_IMAGE="${FN_IMAGE_BASE}.img"

    #export DN_TOOLCHAIN_UBOOT="${srcdir}/toolchains-uboot-${MACHINEARCH}"
    #export DN_TOOLCHAIN_KERNEL="${srcdir}/toolchains-kernel-${MACHINEARCH}"
    export DN_TOOLCHAIN_UBOOT="${srcdir}/"
    export DN_TOOLCHAIN_KERNEL="${srcdir}/"

    DN_ROOTFS_KERNEL="${srcdir}/rootfs-kernel-${MACHINEARCH}-${pkgname}"
    DN_BOOT_4KERNEL="${DN_ROOTFS_KERNEL}${MNTPOINT_BOOT_FIRMWARE}"
    DN_ROOTFS_DEBIAN="${srcdir}/rootfs-kali-${MACHINEARCH}-${pkgname}"

    export ARCH=arm
    if [ "${ISCROSS}" = "1" ]; then
        export PATH=${DN_TOOLCHAIN_KERNEL}/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/:$PATH
        export CROSS_COMPILE=arm-linux-gnueabihf-
    else
        export CROSS_COMPILE=
        unset CROSS_COMPILE
    fi

    mkdir -p "${DN_ROOTFS_KERNEL}"
    mkdir -p "${DN_BOOT_4KERNEL}"
    mkdir -p "${DN_ROOTFS_DEBIAN}"
    my0_check_valid_path "${DN_ROOTFS_KERNEL}"
    my0_check_valid_path "${DN_BOOT_4KERNEL}"
    my0_check_valid_path "${DN_ROOTFS_DEBIAN}"
}

prepare_hardkernel_toolchains () {
    echo "[DBG] in prepare_hardkernel_toolchains() ..."
    # 32bit compiler
    #echo "[DBG] prepare u-boot toolchain at ${DN_TOOLCHAIN_UBOOT} ..."
    #mkdir -p ${DN_TOOLCHAIN_UBOOT}
    #tar xf ${srcdir}/gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz -C ${DN_TOOLCHAIN_UBOOT}

    #echo "[DBG] create toolchain dir for kernel ..."
    #mkdir -p ${DN_TOOLCHAIN_KERNEL}
    #tar xf "${srcdir}/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.xz" -C "${DN_TOOLCHAIN_KERNEL}"
}

prepare_hardkernel_uboot () {
    echo "[DBG] cd ${srcdir}/${DNSRC_UBOOT} ..."
    cd "${srcdir}/${DNSRC_UBOOT}"
    if [ "${USE_GIT_REPO}" = "1" ]; then
        git checkout odroidc-v2011.03
        if [ ! "$?" = "0" ]; then
            echo "Error in git"
            exit 1
        fi
    fi
}

prepare_hardkernel_kernel () {
    # linux kernel for odroid
    cd "${srcdir}/${DNSRC_LINUX}"
    if [ "${USE_GIT_REPO}" = "1" ]; then
        git submodule init
        git submodule update
        git pull --all
        git checkout odroidc-3.10.y
    fi

    patch -p1 --no-backup-if-mismatch < ${srcdir}/kali-wifi-injection-chan.c.patch
    if [ ! "$?" = "0" ]; then
        echo "error in patch kali-wifi-injection-chan.c.patch"
        exit 1
    fi
    patch -p1 --no-backup-if-mismatch < ${srcdir}/${PATCH_MAC80211}
    if [ ! "$?" = "0" ]; then
        echo "error in patch ${PATCH_MAC80211}"
        exit 1
    fi
    touch .scmversion

    #make mrproper
    make ${MAKE_CONFIG} # generate .config
    cp ${srcdir}/${CONFIG_KERNEL} .config # or use ours
    patch -p0 --no-backup-if-mismatch < ${srcdir}/${PATCH_CONFIG_KERNEL}
    if [ ! "$?" = "0" ]; then
        echo "error in patch ${PATCH_CONFIG_KERNEL}"
        exit 1
    fi

    # config ZRAM
    sed -i 's|^[#\w ]*CONFIG_ZRAM=.*$|CONFIG_ZRAM=m|' .config

    make oldconfig && make prepare

    #make modules_prepare
    #cp "${srcdir}/firmware-raspberrypi-git/extra/Module.symvers" . # copy Module.sysmvers to the linux directory
}

build_hardkernel_uboot () {
    cd "${srcdir}/${DNSRC_UBOOT}"

    export ARCH=arm
    if [ "${ISCROSS}" = "1" ]; then
        # 32bit compiler
        export PATH=${DN_TOOLCHAIN_UBOOT}/gcc-linaro-arm-none-eabi-4.8-2014.04_linux/bin/:$PATH
        export CROSS_COMPILE=arm-none-eabi-
    else
        export CROSS_COMPILE=
        unset CROSS_COMPILE
    fi

    echo "[DBG] PATH=${PATH}"
    make -j $MACHINECORES odroidc_config
    make -j $MACHINECORES

    sudo cp "${srcdir}/boot.ini.template"   "${DN_BOOT_4KERNEL}/boot.ini"
    # use the serial in the 40pin slot
    #-e 's|console=ttyS0|console=ttyS2|'

    #sed -i 's|^\(setenv vout_mode .*\)$|#\1|' "${DN_BOOT_4KERNEL}/boot.ini"
    #sed -i 's|^#[\w ]*\(setenv vout_mode "dvi".*\)$|\1|' "${DN_BOOT_4KERNEL}/boot.ini"
    sudo sed -i \
        -e 's|root=/dev/mmcblk0p1|root=/dev/mmcblk0p2|' \
        "${DN_BOOT_4KERNEL}/boot.ini"

    sudo cp "${srcdir}/${DNSRC_UBOOT}/sd_fuse/bl1.bin.hardkernel" "${DN_BOOT_4KERNEL}/"
    sudo cp "${srcdir}/${DNSRC_UBOOT}/sd_fuse/u-boot.bin"         "${DN_BOOT_4KERNEL}/"
    sudo cp "${srcdir}/sd_fusing.sh"                              "${DN_BOOT_4KERNEL}/"
}

install_hardkernel_uboot () {
    PARAM_FN_IMAGE=$1
    shift

    echo "[DBG] Install U-Boot ..."
    DEV_LOOP=$(sudo losetup -f --show ${PARAM_FN_IMAGE})
    if [ "${DEV_LOOP}" = "" ]; then
        echo "error in losetup"
        exit 1
    fi

    BL1=${srcdir}/${DNSRC_UBOOT}/sd_fuse/bl1.bin.hardkernel
    UBOOT=${srcdir}/${DNSRC_UBOOT}/sd_fuse/u-boot.bin
if [ 0 = 1 ]; then
    if [ ! -f $BL1 ]; then
        echo "Error: $BL1 does not exist."
        exit 0
    fi

    if [ ! -f $UBOOT ]; then
        echo "Error: $UBOOT does not exist."
        exit 0
    fi

    # install BL1/MBR
    sudo dd if=$BL1   of=${DEV_LOOP} bs=1 count=442
    sudo dd if=$BL1   of=${DEV_LOOP} bs=512 skip=1 seek=1
    # install u-boot:
    sudo dd if=$UBOOT of=${DEV_LOOP} bs=512 seek=64
else
    ( cd ${srcdir}/${DNSRC_UBOOT}/sd_fuse && sh sd_fusing.sh ${DEV_LOOP} )
fi

    sudo losetup -d ${DEV_LOOP}
}

prepare_hardkernel_rootfs () {
    # addtional setup for the rootfs

    echo "Enable the Serial console"
if [ 1 = 1 ]; then # for debug
    echo "echo 'T0:123:respawn:/sbin/getty -L ttyS0 115200 vt100' >> ${DN_ROOTFS_DEBIAN}/etc/inittab" | sudo sh
else
    # Ubuntu
    sudo mkdir -p "${DN_ROOTFS_DEBIAN}/etc/init/"
    T="${PREFIX_TMP}-ttyS0.conf"
    cat << EOF > "${T}"
# ttyS0 - getty
#
# This service maintains a getty on ttyS0 from the point the system is
# started until it is shut down again.

start on stopped rc or RUNLEVEL=[12345]
stop on runlevel [!12345]

respawn
exec /sbin/getty -L 115200 ttyS0 vt102
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/init/ttyS0.conf"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi
fi

    # if use hdr, uncomment following
    #ROOT_UUID=$(blkid $rootp | sed -n 's/.*UUID=\"\([^\"]*\)\".*/\1/p')
    #sudo sed -i -e "s/root=[^\w ]*/root=${ROOT_UUID}/" "${DN_BOOT_4KERNEL}/boot.int"

    sudo mkdir -p "${DN_ROOTFS_DEBIAN}/etc/udev/rules.d/"

    T="${PREFIX_TMP}-10-odroid_am.rules"
    cat << EOF > "${T}"
KERNEL=="amstream*",SUBSYSTEM=="amstream-dev",MODE="0666",GROUP="video"
KERNEL=="amvideo*",SUBSYSTEM=="video",MODE="0666",GROUP="video"
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/udev/rules.d/10-odroid_am.rules"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    T="${PREFIX_TMP}-10-odroid_mali.rules"
    cat << EOF > "${T}"
KERNEL=="mali",SUBSYSTEM=="misc",MODE="0777",GROUP="video"
KERNEL=="ump",SUBSYSTEM=="ump",MODE="0777",GROUP="video"
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/udev/rules.d/10-odroid_mali.rules"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    T="${PREFIX_TMP}-10-odroid-shield.rules"
    cat << EOF > "${T}"
KERNEL=="ttySAC0", SYMLINK+="ttyACM99"
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/udev/rules.d/10-odroid-shield.rules"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    T="${PREFIX_TMP}-50-odroid-hdmi.rules"
    cat << EOF > "${T}"
KERNEL=="fb1", SYMLINK+="fb6"
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/udev/rules.d/50-odroid-hdmi.rules"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    T="${PREFIX_TMP}-60-odroid-cec.rules"
    cat << EOF > "${T}"
KERNEL=="CEC", MODE="0777"
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/udev/rules.d/60-odroid-cec.rules"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    T="${PREFIX_TMP}-99-input.rules"
    cat << EOF > "${T}"
KERNEL=="event*",NAME="input/%k",MODE="0660",GROUP="plugdev"
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/udev/rules.d/99-input.rules"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    # x window
    sudo mkdir -p ${DN_ROOTFS_DEBIAN}/etc/X11/
    sudo mv ${DN_ROOTFS_DEBIAN}/etc/X11/xorg.conf ${DN_ROOTFS_DEBIAN}/etc/X11/xorg.conf.old
    T="${PREFIX_TMP}-xorg.conf"
    cat << EOF > "${T}"
Section "Screen"
  Identifier "Default Screen"
  Monitor "Configured Monitor"
  Device "Configured Video Device"
  DefaultDepth 16
EndSection
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/X11/xorg.conf"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    # SOUND
    T="${PREFIX_TMP}-asound.conf"
    cat << EOF > "${T}"
pcm.!default {
  type plug
  slave {
    pcm "hw:0,1"
  }
}
ctl.!default {
  type hw
  card 0
}
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/asound.conf"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    sudo sed -i \
        -e "s|^#[\w ]*load-module module-alsa-sink|load-module module-alsa-sink|g" \
        -e "s|^#[\w ]*load-module module-alsa-source device=hw:1,0|load-module module-alsa-source device=hw:0,1|g" \
        ${DN_ROOTFS_DEBIAN}/etc/pulse/default.pa

    if [ ! -f ${DN_ROOTFS_DEBIAN}/etc/rc.local ]; then
        echo "echo 'exit 0' >> ${DN_ROOTFS_DEBIAN}/etc/rc.local" | sudo sh
        sudo chmod 755 ${DN_ROOTFS_DEBIAN}/etc/rc.local
    fi

    #sudo sed -i -e "/^[^#]*exit 0/i\echo 0 > /sys/devices/platform/mesonfb/graphics/fb1/blank" ${DN_ROOTFS_DEBIAN}/etc/rc.local
    grep -v 'echo 0 > /sys/devices/platform/mesonfb/graphics/fb1/blank' ${DN_ROOTFS_DEBIAN}/etc/rc.local > tmp
    sed -i -e "/^[^#]*exit 0/i\echo 0 > /sys/devices/platform/mesonfb/graphics/fb1/blank" tmp
    chmod 755 tmp
    sudo mv tmp ${DN_ROOTFS_DEBIAN}/etc/rc.local

    # http://www.armadeus.com/wiki/index.php?title=FrameBuffer
    # change the cursor color
    #PROMPT_COMMAND='echo -e "\033[?16;0;200c"'
    # blinking
    #echo 1 > /sys/class/graphics/fbcon/cursor_blink

    # Set tmux to show the cursor
    T="${PREFIX_TMP}-tmux.conf"
    if [ -f "${DN_ROOTFS_DEBIAN}/etc/tmux.conf" ]; then
        cp "${DN_ROOTFS_DEBIAN}/etc/tmux.conf" "${T}"
    fi
    cat << EOF >> "${T}"
setw -ga terminal-overrides ',*:Cc=\E[?120;%p1%s;240c:Cr=\E[?120;0;240c:civis=\E[?25l:cnorm=\E[?25h:cvvis=\E[?25h,'
set -g status-bg black
set -g status-fg white
EOF
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/tmux.conf"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

    T="${PREFIX_TMP}-bashrc"
    if [ -f "${DN_ROOTFS_DEBIAN}/etc/bash.bashrc" ]; then
        cp "${DN_ROOTFS_DEBIAN}/etc/bash.bashrc" "${T}"
    fi
    cat "${srcdir}/bash.bashrc.template" >> "${T}"
    sudo mv "${T}" "${DN_ROOTFS_DEBIAN}/etc/bash.bashrc"
    if [ ! "$?" = "0" ]; then
        echo "Error in move file $T"
        exit 1
    fi

if [ 0 = 1 ]; then
    # TO be verified ....
    # http://forum.odroid.com/viewtopic.php?f=114&t=8281
    # http://forum.odroid.com/viewtopic.php?f=115&t=8121#p64249
    # ArchLinux: Improve network speed
    sudo sed -i \
        -e "/exit 0/i\echo 32768 > /proc/sys/net/core/rps_sock_flow_entries" \
        -e "/exit 0/i\echo 2048 > /sys/class/net/eth0/queues/rx-0/rps_flow_cnt" \
        -e "/exit 0/i\echo f > /sys/class/net/eth0/queues/rx-0/rps_cpus" \
        -e "/exit 0/i\# Set XPS" \
        -e "/exit 0/i\echo c > /sys/class/net/eth0/queues/tx-0/xps_cpus" \
        -e "/exit 0/i\#Reconnect" \
        -e "/exit 0/i\ifconfig eth0 down" \
        ${DN_ROOTFS_DEBIAN}/etc/rc.local

    # Slow Network speeds over NFS
    # http://forum.odroid.com/viewtopic.php?f=117&t=8096
    echo "echo 'blacklist rpcsec_gss_krb5' >> ${DN_ROOTFS_DEBIAN}/etc/modprobe.d/blacklist.conf" | sudo sh
fi

    FILES=`cat ${srcdir}/odroid-utility-git/files.txt`
    for fu in odroid-utility.sh $FILES; do
        sudo cp ${srcdir}/odroid-utility-git/$fu ${DN_ROOTFS_DEBIAN}/usr/local/bin/
    done
    # patch for kali:
    sed -i \
        -e  '/"Debian")/ i\Kali) export DISTRO="debian" ;;' \
        -e  's@`curl -s $baseurl/files.txt`@`curl -s $baseurl/files.txt|grep -v odroid-utility.sh`@' \
        ${DN_ROOTFS_DEBIAN}/usr/local/bin/odroid-utility.sh

    sudo chmod +x ${DN_ROOTFS_DEBIAN}/usr/local/bin/odroid-utility.sh
}

# check if the file exist in the created image file
# pass in the mounted root path of the image file
check_hardkernel_rootfs() {
    PARAM_ROOT=$1
    shift

    chkfile_hardkernel=(
        "${MNTPOINT_BOOT_FIRMWARE}/boot.ini"
        "${MNTPOINT_BOOT_FIRMWARE}/bl1.bin.hardkernel"
        "${MNTPOINT_BOOT_FIRMWARE}/u-boot.bin"
        "${MNTPOINT_BOOT_FIRMWARE}/sd_fusing.sh"
        "${MNTPOINT_BOOT_FIRMWARE}/dtbs/meson8b_odroidc.dtb"
        "${MNTPOINT_BOOT_FIRMWARE}/uImage"

        /etc/udev/rules.d/10-odroid_am.rules
        /etc/udev/rules.d/10-odroid_mali.rules
        /etc/udev/rules.d/10-odroid-shield.rules
        /etc/udev/rules.d/50-odroid-hdmi.rules
        /etc/udev/rules.d/60-odroid-cec.rules
        /etc/udev/rules.d/99-input.rules
        /etc/X11/xorg.conf
        /etc/asound.conf
        /usr/local/bin/odroid-utility.sh
    )
    FLG_ERROR=0
    for i in ${chkfile_hardkernel[*]} ; do
        if [ ! -f "${PARAM_ROOT}/${i}" ]; then
            FLG_ERROR=1
            echo "Error: not found required file at ${PARAM_ROOT}/${i}"
        fi
    done
    if [ "${FLG_ERROR}" = "1" ]; then
        echo "[DBG] check file error!"
        exit 1
    fi
}


# create a image file with two partitions: /boot/ and /
check_kali_image() {
    PARAM_FN_IMAGE="$1"
    shift

    echo "[DBG] check_kali_image() ..."
    # Create the disk and partition it
    if [[ ! -f "${PARAM_FN_IMAGE}" ]]; then
        echo "Error: Not found image file ${PARAM_FN_IMAGE}"
        exit 1
    fi

    # Set the partition variables
    DEV_LOOP=$(sudo losetup -f --show ${PARAM_FN_IMAGE})
    if [ "${DEV_LOOP}" = "" ]; then
        echo "error in losetup"
        exit 1
    fi
    LOOPNAME=$(sudo kpartx -va ${DEV_LOOP} | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1)
    if [ "${LOOPNAME}" = "" ]; then
        echo "Error in loop device 2: ${DEV_LOOP}"
        exit 1
    fi
    #partprobe "${DEV_LOOP}" # to get /dev/loop0p1 ...
    bootp="/dev/mapper/${LOOPNAME}p1"
    rootp="/dev/mapper/${LOOPNAME}p2"

    # Create the dirs for the partitions and mount them
    DN_ROOT="${srcdir}/mntrootfs-${MACHINEARCH}-${pkgname}-checker"
    mkdir -p ${DN_ROOT}
    sudo mount $rootp ${DN_ROOT}
    if [ ! "$?" = "0" ]; then
        echo "error in mount root "
        exit 1
    fi

    DN_BOOT_4IMAGE="${DN_ROOT}${MNTPOINT_BOOT_FIRMWARE}"
    sudo mkdir -p ${DN_BOOT_4IMAGE}
    if [ ! "$?" = "0" ]; then
        echo "error in mkdir ${DN_BOOT_4IMAGE}"
        exit 1
    fi
    sudo mount $bootp ${DN_BOOT_4IMAGE}
    if [ ! "$?" = "0" ]; then
        echo "error in mount boot"
        exit 1
    fi

    check_hardkernel_rootfs "${DN_ROOT}"

    # Unmount partitions
    sudo umount ${DN_BOOT_4IMAGE}
    sudo umount ${DN_ROOT}
    sudo kpartx -dv ${DEV_LOOP}
    sudo losetup -d ${DEV_LOOP}
    if [ ! "$?" = "0" ]; then
        echo "error in losetup"
        exit 1
    fi
}

prepare() {
    my_setevn
    #rm -f "${FN_IMAGE}" ${PREFIX_TMP}*

    rm -rf ${DN_BOOT_4KERNEL}
    rm -rf ${DN_ROOTFS_KERNEL}
    #rm -rf ${DN_ROOTFS_DEBIAN}
    mkdir -p ${DN_BOOT_4KERNEL}
    mkdir -p ${DN_ROOTFS_KERNEL}
    mkdir -p ${DN_ROOTFS_DEBIAN}

    prepare_hardkernel_toolchains

    prepare_hardkernel_uboot
    prepare_hardkernel_kernel

    echo "Build rootfs ..."
    cd ${srcdir}
    # create rootfs
    kali_rootfs_debootstrap
    prepare_hardkernel_rootfs
    echo "Build rootfs DONE!"
}

build() {
    my_setevn

    echo "Build U-Boot ..."
    build_hardkernel_uboot
    echo "Build U-Boot DONE!"

    export ARCH=arm
    if [ "${ISCROSS}" = "1" ]; then
        export PATH=${DN_TOOLCHAIN_KERNEL}/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/:$PATH
        export CROSS_COMPILE=arm-linux-gnueabihf-
    else
        export CROSS_COMPILE=
        unset CROSS_COMPILE
    fi
    echo "Build Linux kernel ..."
    cd "${srcdir}/${DNSRC_LINUX}"
    kali_rootfs_linuxkernel
    echo "Build Linux kernel DONE!"
}

package() {
    my_setevn

    kali_create_image "${DN_ROOTFS_DEBIAN}" "${DN_ROOTFS_KERNEL}"

    cd ${srcdir}
    #make DESTDIR="$pkgdir/" install
    mkdir -p "${pkgdir}/usr/share/${pkgname}"
    cp ${FN_IMAGE}* "${pkgdir}/usr/share/${pkgname}"
}
