# Maintainer: Yunhui Fu <yhfudev at gmail dot com>

pkgname=kali-odroidc1-image
pkgver=1.1.0
pkgrel=1
pkgdesc="Odroid C1 Kali image"
arch=('i686' 'x86_64' 'arm')
url="https://github.com/yhfudev/arch-kali-odroidc1.git"
license=('GPL')
depends=(
    'gcc-libs' 'bash' 'ncurses'
    'qemu' 'qemu-user-static' 'binfmt-support' # cross compile and chroot
    'debootstrap' # to create debian rootfs
    'parted' 'dosfstools'
    'lib32-libstdc++5' 'lib32-zlib' # for 32 bit compiler
    #'build-essential' 'devscripts' 'fakeroot' 'kernel-package' # debian packages
    )
makedepends=('git')
#install="$pkgname.install"
#PKGEXT=.pkg.tar.xz

provides=('kali-odroidc1-git')
conflicts=('kali-odroidc1')

# config for Odroid C1
ARCHITECTURE="armhf"
PATCH_MAC80211="kali-arm-build-scripts-git/patches/kali-wifi-injection-3.12.patch"
#PATCH_MAC80211="kali-wifi-injection-3.18.patch"
CONFIG_KERNEL="odroidc1-3.10.config"
PATCH_CONFIG_KERNEL="odroidc1-kernel-config.patch"


# Package installations for various sections.
# This will build a minimal XFCE Kali system with the top 10 tools.
# This is the section to edit if you would like to add more packages.
# See http://www.kali.org/new/kali-linux-metapackages/ for meta packages you can
# use. You can also install packages, using just the package name, but keep in
# mind that not all packages work on ARM! If you specify one of those, the
# script will throw an error, but will still continue on, and create an unusable
# image, keep that in mind.
PACKAGES_ARM="abootimg cgpt fake-hwclock ntpdate vboot-utils vboot-kernel-utils uboot-mkimage"
PACKAGES_BASE="kali-menu kali-defaults initramfs-tools sudo parted e2fsprogs usbutils"
PACKAGES_DESKTOP="xfce4 network-manager network-manager-gnome xserver-xorg-video-fbdev"
PACKAGES_TOOLS="passing-the-hash winexe aircrack-ng hydra john sqlmap wireshark libnfc-bin mfoc nmap ethtool"
PACKAGES_SERVICES="openssh-server apache2"
PACKAGES_EXTRAS="iceweasel wpasupplicant"
export PACKAGES="${PACKAGES_ARM} ${PACKAGES_BASE} ${PACKAGES_DESKTOP} ${PACKAGES_TOOLS} ${PACKAGES_SERVICES} ${PACKAGES_EXTRAS}"

# the image container size
IMGCONTAINER_SIZE=3000 # Size of image in megabytes

# If you have your own preferred mirrors, set them here.
# You may want to leave security.kali.org alone, but if you trust your local
# mirror, feel free to change this as well.
# After generating the rootfs, we set the sources.list to the default settings.
export INSTALL_MIRROR=http.kali.org
export INSTALL_SECURITY=security.kali.org

source=(
        "kali-arm-build-scripts::git+https://github.com/yhfudev/kali-arm-build-scripts.git"
        "linux-hardkernel-git::git+https://github.com/hardkernel/linux.git" # kernel
        "http://dn.odroid.com/toolchains/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.xz" #http://releases.linaro.org/14.09/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.xz
        "firmware-linux-git::git+https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git"
        "kali-wifi-injection-3.18.patch" #"mac80211.patch::https://raw.github.com/offensive-security/kali-arm-build-scripts/master/patches/kali-wifi-injection-3.12.patch"
        "odroidc1-3.10.config"
        "odroidc1-kernel-config.patch"

        # u-boot
        "http://dn.odroid.com/toolchains/gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz"
        "uboot-hardkernel-git::git+https://github.com/hardkernel/u-boot.git"
        )

md5sums=(
         'SKIP'
         'SKIP'
         'd7805745171f63c2556083e20abbd8eb' # gcc for kernel
         'SKIP'
         'SKIP'
         '37b89f74e3f9f6c20295da564ece5b8f'
         'e54725fa965b4b8531563f40a420a40c'
         'a658e75a84cf9fe0874baad602049703'
         '12d6e8a0cbd2d8e130cc8f55389a95c3' # gcc for uboot
         'SKIP'
         )
sha1sums=(
         'SKIP'
         'SKIP'
         'b6d5f985ac254b1d60d8f01459f64d248adb7838'
         'SKIP'
         'SKIP'
         '48ce0c7886128fb068b70b5692b60a6c5aec0e96'
         '95cb733d04afb2960beb7c4f5090ca47b943c8d0'
         '125003dfdbef989b8e2cf1bc19cdac45df8742e1'
         '8069f484cfd5a7ea02d5bb74b56ae6c99e478d13'
         'SKIP'
         )

pkgver() {
    cd "$srcdir/$pkgname"
    local ver="$(git show | grep commit | awk '{print $2}'  )"
    #printf "r%s" "${ver//[[:alpha:]]}"
    echo ${ver:0:7}
}

PREFIX_TMP="${srcdir}/tmptmp"

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

kali_rootfs_debootstrap() {
    PARAM_DN_DEBIAN=$1
    shift
    PARAM_DN_RPI=$1
    shift

    # the apt cache folder
    DN_APT_CACHE="${SRCPKGDEST}/apt-cache-kali-${MACHINEARCH}"
    mkdir -p "${DN_APT_CACHE}"
    mkdir -p "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives"

    # build kali rootfs
    cd "$srcdir"

    if [ ! -f /usr/share/debootstrap/scripts/kali ]; then
        sudo ln -s /usr/share/debootstrap/scripts/sid /usr/share/debootstrap/scripts/kali
    fi

    if [ "${ISCROSS}" = "1" ]; then
        register_qemuarm
    fi

    sudo mount -o bind "${DN_APT_CACHE}" "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives"

    echo "[DBG] debootstrap state 1"
    if [[ -f "${PREFIX_TMP}_FLG_KALI_ROOTFS_STAGE1" ]]; then
        echo "[DBG] SKIP debootstrap state 1"

    else
        # create the rootfs - not much to modify here, except maybe the hostname.
        echo "[DBG] debootstrap --foreign --arch ${MACHINEARCH} kali '${DN_ROOTFS_DEBIAN}'  http://${INSTALL_MIRROR}/kali"
        sudo debootstrap --foreign --arch ${MACHINEARCH} kali "${DN_ROOTFS_DEBIAN}" "http://${INSTALL_MIRROR}/kali"
        if [ "$?" = "0" ]; then
            touch "${PREFIX_TMP}_FLG_KALI_ROOTFS_STAGE1"
        fi
    fi

    if [ "${ISCROSS}" = "1" ]; then
        sudo cp /usr/bin/qemu-arm-static "${DN_ROOTFS_DEBIAN}/usr/bin/"
    fi

    echo "[DBG] debootstrap state 2"
    if [[ -f "${PREFIX_TMP}_FLG_KALI_ROOTFS_STAGE2" ]]; then
        echo "[DBG] SKIP debootstrap state 2"

    else
        sudo chroot "${DN_ROOTFS_DEBIAN}" /usr/bin/env -i LANG=C /debootstrap/debootstrap --second-stage
        if [ "$?" = "0" ]; then
            touch "${PREFIX_TMP}_FLG_KALI_ROOTFS_STAGE2"
        fi
    fi

    echo "[DBG] debootstrap state 2.5"
    # Create sources.list
    cat << EOF > /tmp/list
deb http://${INSTALL_MIRROR}/kali kali main contrib non-free
deb http://${INSTALL_SECURITY}/kali-security kali/updates main contrib non-free
EOF
    sudo mv /tmp/list "${DN_ROOTFS_DEBIAN}/etc/apt/sources.list"

    # Set hostname

    echo "echo kali > '${DN_ROOTFS_DEBIAN}/etc/hostname'" | sudo sh

    # So X doesn't complain, we add kali to hosts
    cat << EOF > /tmp/host
127.0.0.1       kali    localhost
::1             localhost ip6-localhost ip6-loopback
fe00::0         ip6-localnet
ff00::0         ip6-mcastprefix
ff02::1         ip6-allnodes
ff02::2         ip6-allrouters
EOF
    sudo mv /tmp/host "${DN_ROOTFS_DEBIAN}/etc/hosts"

    cat << EOF > /tmp/net
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
EOF
    sudo mv /tmp/net "${DN_ROOTFS_DEBIAN}/etc/network/interfaces"

    cat << EOF > /tmp/reso
nameserver 8.8.8.8
EOF
    sudo mv /tmp/reso "${DN_ROOTFS_DEBIAN}/etc/resolv.conf"

    export MALLOC_CHECK_=0 # workaround for LP: #520465
    export LC_ALL=C
    export DEBIAN_FRONTEND=noninteractive

    cat << EOF > /tmp/deb
console-common console-data/keymap/policy select Select keymap from full list
console-common console-data/keymap/full select en-latin1-nodeadkeys
EOF
    sudo mv /tmp/deb "${DN_ROOTFS_DEBIAN}/debconf.set"

    echo "[DBG] debootstrap state 3"
    if [[ -f "${PREFIX_TMP}_FLG_KALI_ROOTFS_STAGE3" ]]; then
        echo "[DBG] SKIP debootstrap state 3"

    else
        #sudo mkdir -p "${DN_ROOTFS_DEBIAN}/proc"
        #sudo mkdir -p "${DN_ROOTFS_DEBIAN}/dev/"
        #sudo mkdir -p "${DN_ROOTFS_DEBIAN}/dev/pts"
        sudo mount -t proc proc "${DN_ROOTFS_DEBIAN}/proc"
        sudo mount -o bind /dev/ "${DN_ROOTFS_DEBIAN}/dev/"
        sudo mount -o bind /dev/pts "${DN_ROOTFS_DEBIAN}/dev/pts"

        cat << EOF > /tmp/ths
#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export DEBIAN_FRONTEND=noninteractive

dpkg-divert --add --local --divert /usr/sbin/invoke-rc.d.chroot --rename /usr/sbin/invoke-rc.d
cp /bin/true /usr/sbin/invoke-rc.d
echo -e "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d
chmod +x /usr/sbin/policy-rc.d

apt-get update
apt-get install locales-all

debconf-set-selections /debconf.set
rm -f /debconf.set
apt-get update
apt-get -y install git-core binutils ca-certificates initramfs-tools uboot-mkimage
apt-get -y install locales console-common less nano git
echo "root:toor" | chpasswd
sed -i -e 's/KERNEL\!=\"eth\*|/KERNEL\!=\"/' /lib/udev/rules.d/75-persistent-net-generator.rules
rm -f /etc/udev/rules.d/70-persistent-net.rules
apt-get --yes --force-yes install $PACKAGES

update-rc.d ssh enable

rm -f /usr/sbin/policy-rc.d
rm -f /usr/sbin/invoke-rc.d
dpkg-divert --remove --rename /usr/sbin/invoke-rc.d

rm -f /third-stage
EOF
        chmod +x /tmp/ths
        sudo mv /tmp/ths "${DN_ROOTFS_DEBIAN}/third-stage"

        sudo chroot "${DN_ROOTFS_DEBIAN}" /third-stage
        if [ "$?" = "0" ]; then
            touch "${PREFIX_TMP}_FLG_KALI_ROOTFS_STAGE3"
        fi
        sudo umount "${DN_ROOTFS_DEBIAN}/var/cache/apt/archives"
    fi

    cat << EOF > /tmp/cln
#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
export DEBIAN_FRONTEND=noninteractive
rm -rf /root/.bash_history
apt-get update
apt-get clean
rm -f /0
rm -f /hs_err*
rm -f /cleanup
rm -f /usr/bin/qemu*
EOF
    chmod +x /tmp/cln
    sudo mv /tmp/cln "${DN_ROOTFS_DEBIAN}/cleanup"

    sudo chroot "${DN_ROOTFS_DEBIAN}" /cleanup

    sudo umount "${DN_ROOTFS_DEBIAN}/proc/sys/fs/binfmt_misc"
    sudo umount "${DN_ROOTFS_DEBIAN}/dev/pts"
    sudo umount "${DN_ROOTFS_DEBIAN}/dev/"
    sudo umount "${DN_ROOTFS_DEBIAN}/proc"

    if [ "${ISCROSS}" = "1" ]; then
        unregister_qemuarm
    fi
}

kali_rootfs_linuxkernel() {
    # compile and install linux kernel for Raspberry Pi 2, install rpi2 specified tools
    CORES=$(grep -c processor /proc/cpuinfo)
    if [ "$CORES" = "" ]; then
        CORES=2
    fi

    # compile linux kernel for Raspberry Pi 2
    make -j $CORES
    make -j $CORES modules

    # install kernel
    make -j $CORES modules_install INSTALL_MOD_PATH=${DN_ROOTFS_RPI2}

    rm -rf ${DN_ROOTFS_RPI2}/lib/firmware
    cd ${DN_ROOTFS_RPI2}/lib
    #git clone --depth 1 https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git firmware
    cp -r ${srcdir}/firmware-linux-git firmware
    rm -rf ${DN_ROOTFS_RPI2}/lib/firmware/.git

if [ 0 = 0 ]; then
    make uImage
    make dtbs
    sudo cp arch/arm/boot/uImage arch/arm/boot/dts/meson8b_odroidc.dtb "${DN_BOOT}"

else
    cp -rf ${srcdir}/firmware-raspberrypi-git/boot/* ${DN_BOOT}
    cp arch/arm/boot/zImage ${DN_BOOT}/kernel.img

    cd ${srcdir}
    cat << EOF > ${DN_BOOT}/cmdline.txt
dwc_otg.lpm_enable=0 console=ttyAMA0,115200 kgdboc=ttyAMA0,115200 console=tty1 elevator=deadline root=/dev/mmcblk0p2 rootfstype=ext4 rootwait
EOF
    # rpi-wiggle
    mkdir -p ${DN_ROOTFS_RPI2}/scripts
    #wget https://raw.github.com/dweeber/rpiwiggle/master/rpi-wiggle -O ${DN_ROOTFS_RPI2}/scripts/rpi-wiggle.sh
    cp ${srcdir}/rpiwiggle-git/rpi-wiggle ${DN_ROOTFS_RPI2}/scripts/rpi-wiggle.sh
    chmod 755 ${DN_ROOTFS_RPI2}/scripts/rpi-wiggle.sh
fi

}

rsync_and_verify() {
    PARAM_DN_SRC="$1"
    shift
    PARAM_DN_DST="$1"
    shift

    sudo rsync -HPavz -q "${PARAM_DN_SRC}" "${PARAM_DN_DST}"

if [ 1 = 0 ]; then
    # verify the files
    cd "${PARAM_DN_SRC}/"
    sudo find . -type f | sudo xargs -n 1 md5sum > /tmp/md5sum-root
    cd -
    cd "${PARAM_DN_DST}"
    sudo md5sum -c /tmp/md5sum-root
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
    PARAM_DN_ROOTFS_RPI2="$1"
    shift

    FN_IMAGE="${srcdir}/${pkgname}-${pkgver}-${MACHINEARCH}.img"
    # Create the disk and partition it

    echo "Creating image file for ${pkgdesc}"
    if [[ ! -f "${FN_IMAGE}" || ! -f "${PREFIX_TMP}_FLG_KALI_CREATE_IMAGE" ]]; then
        # check Ubuntu Partition Table http://odroid.com/dokuwiki/doku.php?id=en:c1_partition_table
        dd if=/dev/zero of=${FN_IMAGE} bs=1M count=${IMGCONTAINER_SIZE}
        parted ${FN_IMAGE} --script -- mklabel msdos
        parted ${FN_IMAGE} --script -- mkpart primary fat32   3072s 266239s
        parted ${FN_IMAGE} --script -- mkpart primary ext4  266240s    100%
        touch "${PREFIX_TMP}_FLG_KALI_CREATE_IMAGE"
    fi
    install_hardkernel_uboot ${FN_IMAGE}

    # Set the partition variables
    DEV_LOOP=$(sudo losetup -f --show ${FN_IMAGE})
    LOOPNAME=$(sudo kpartx -va ${DEV_LOOP} | sed -E 's/.*(loop[0-9])p.*/\1/g' | head -1)
    DEVICE="/dev/mapper/${LOOPNAME}"
    bootp=${DEVICE}p1
    rootp=${DEVICE}p2

    # Create file systems
    sudo mkfs.vfat -n boot $bootp
    sudo mkfs.ext4 -L root $rootp

    # Create the dirs for the partitions and mount them
    DN_ROOT="${srcdir}/mntrootfs-${MACHINEARCH}"
    mkdir -p ${DN_ROOT}
    sudo mount $rootp ${DN_ROOT}

    DN_BOOT=${DN_ROOT}/boot
    sudo mkdir -p ${DN_BOOT}
    sudo mount $bootp ${DN_BOOT}

    echo "Rsyncing rootfs into image file"
    rsync_and_verify "${PARAM_DN_ROOTFS_DEBIAN}/" ${DN_ROOT}/

    echo "Rsyncing kernel into image file"
    rsync_and_verify "${PARAM_DN_ROOTFS_RPI2}/"   ${DN_ROOT}/

    # Enable login over serial
    echo "echo 'T0:23:respawn:/sbin/agetty -L ttyAMA0 115200 vt100' >> ${DN_ROOT}/etc/inittab" | sudo sh

    cat << EOF > /tmp/aptlst
deb http://http.kali.org/kali kali main non-free contrib
deb http://security.kali.org/kali-security kali/updates main contrib non-free

deb-src http://http.kali.org/kali kali main non-free contrib
deb-src http://security.kali.org/kali-security kali/updates main contrib non-free
EOF
    sudo mv /tmp/aptlst "${DN_ROOT}/etc/apt/sources.list"

    # Unmount partitions
    sudo umount ${DN_BOOT}
    sudo umount ${DN_ROOT}
    sudo kpartx -dv ${DEV_LOOP}
    sudo losetup -d ${DEV_LOOP}

    # Clean up all the temporary build stuff and remove the directories.
    # Comment this out to keep things around if you want to see what may have gone
    # wrong.
    #echo "Cleaning up the temporary build files..."
    #rm -rf ${basedir}/kernel ${basedir}/bootp ${basedir}/root ${basedir}/kali-${MACHINEARCH} ${basedir}/boot ${basedir}/tools ${basedir}/patches

    # If you're building an image for yourself, comment all of this out, as you
    # don't need the sha1sum or to compress the image, since you will be testing it
    # soon.
    echo "Generating sha1sum for ${FN_IMAGE}"
    sha1sum ${FN_IMAGE} > ${FN_IMAGE}.sha1sum
    # Don't pixz on 32bit, there isn't enough memory to compress the images.
    MACHINE_TYPE=$(uname -m)
    if [ ${MACHINE_TYPE} == 'x86_64' ]; then
        echo "Compressing ${FN_IMAGE}"
        xz ${FN_IMAGE} ${FN_IMAGE}.xz
        if [ "$?" = "0" ]; then
            rm -f ${FN_IMAGE}
            echo "Generating sha1sum for ${FN_IMAGE}.xz"
            sha1sum ${FN_IMAGE}.xz > ${FN_IMAGE}.xz.sha1sum
        fi
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

    export DN_TOOLCHAIN_UBOOT="${srcdir}/toolchains-uboot-${MACHINEARCH}"
    export DN_TOOLCHAIN_KERNEL="${srcdir}/toolchains-kernel-${MACHINEARCH}"

    DN_ROOTFS_RPI2="${srcdir}/rootfs-odroidc1-${MACHINEARCH}"
    DN_BOOT="${DN_ROOTFS_RPI2}/boot"
    DN_ROOTFS_DEBIAN="${srcdir}/rootfs-kali-${MACHINEARCH}"

    export ARCH=arm
    if [ "${ISCROSS}" = "1" ]; then
        export PATH=${DN_TOOLCHAIN_KERNEL}/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux/bin/:$PATH
        export CROSS_COMPILE=arm-linux-gnueabihf-
    else
        export CROSS_COMPILE=
        unset CROSS_COMPILE
    fi
}

prepare_hardkernel_toolchains () {
    # 32bit compiler
    echo "[DBG] prepare u-boot toolchain at ${DN_TOOLCHAIN_UBOOT} ..."
    mkdir -p ${DN_TOOLCHAIN_UBOOT}
    tar xf ${srcdir}/gcc-linaro-arm-none-eabi-4.8-2014.04_linux.tar.xz -C ${DN_TOOLCHAIN_UBOOT}

    echo "[DBG] create toolchain dir for kernel ..."
    mkdir -p ${DN_TOOLCHAIN_KERNEL}
    tar xf "${srcdir}/gcc-linaro-arm-linux-gnueabihf-4.9-2014.09_linux.tar.xz" -C "${DN_TOOLCHAIN_KERNEL}"
}

prepare_hardkernel_uboot () {
    echo "[DBG] cd ${srcdir}/uboot-hardkernel-git ..."
    cd "${srcdir}/uboot-hardkernel-git"
    git checkout odroidc-v2011.03
    if [ ! "$?" = "0" ]; then
        echo "Error in git"
        exit 1
    fi
}

prepare_hardkernel_kernel () {
    # linux kernel for odroid
    cd "${srcdir}/linux-hardkernel-git"
    git submodule init
    git submodule update
    git pull --all
    git checkout odroidc-3.10.y

    patch -p1 --no-backup-if-mismatch < ${srcdir}/${PATCH_MAC80211}
    touch .scmversion

    make odroidc_defconfig
    cp ${srcdir}/${CONFIG_KERNEL} .config
    patch -p0 --no-backup-if-mismatch < ${srcdir}/${PATCH_CONFIG_KERNEL}
}

build_hardkernel_uboot () {
    cd ${srcdir}/uboot-hardkernel-git

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
    make odroidc_config
    make
}

install_hardkernel_uboot () {
    PARAM_FN_IMAGE=$1
    shift

    cd ${srcdir}/uboot-hardkernel-git

if [ 0 = 1 ]; then
    BL1=bl1.bin.hardkernel
    UBOOT=u-boot.bin
    # install BL1/MBR
    sudo dd if=$BL1   of=${PARAM_FN_IMAGE} bs=1 count=442
    sudo dd if=$BL1   of=${PARAM_FN_IMAGE} bs=512 skip=1 seek=1
    # install u-boot:
    sudo dd if=$UBOOT of=${PARAM_FN_IMAGE} bs=512 seek=64
else
    cd sd_fuse
    sh sd_fusing.sh ${PARAM_FN_IMAGE}
fi
}

prepare() {
    my_setevn
    rm -f ${PREFIX_TMP}*

    rm -rf ${DN_BOOT}
    rm -rf ${DN_ROOTFS_RPI2}
    #rm -rf ${DN_ROOTFS_DEBIAN}
    mkdir -p ${DN_BOOT}
    mkdir -p ${DN_ROOTFS_RPI2}
    mkdir -p ${DN_ROOTFS_DEBIAN}

    prepare_hardkernel_toolchains

    prepare_hardkernel_uboot
    prepare_hardkernel_kernel

    echo "Build rootfs ..."
    cd ${srcdir}
    # create rootfs
    kali_rootfs_debootstrap
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
    cd "$srcdir/linux-raspberrypi-git"
    kali_rootfs_linuxkernel
    echo "Build Linux kernel DONE!"
}

package() {
    kali_create_image "${DN_ROOTFS_DEBIAN}" "${DN_ROOTFS_RPI2}"

    cd ${srcdir}
    #make DESTDIR="$pkgdir/" install
    mkdir -p "${pkgdir}/usr/share/${pkgname}"
    cp ${FN_IMAGE}* "${pkgdir}/usr/share/${pkgname}"
}
