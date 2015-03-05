arch-kali-odroidc1
==============

The build scripts for Kali image of Odroid C1,
supports both Debian & Arch Linux.


Build
-----

You may compile the kali image for Odroid C1 in one step:

    git clone https://github.com/yhfudev/arch-kali-odroidc1.git
    cd arch-kali-odroidc1
    ./runme.sh

You may want to run above commands in a virtual machine by user root,
otherwise you may be annoyed by the sudo command :-)

Install
-------
Install to SD card by:

    dd bs=4M if=src/kali-odroidc1-image-1.1.0-armhf.img of=/dev/mmcblk0 && sync


Config
------
You may be also interest in config or install other packages after booting the Kali:

    # expanded the image to the full size
    apt-get install parted sudo
    /scripts/rpi-wiggle.sh
    
    # Full Kali Linux build
    apt-get update
    apt-get install kali-linux-full
    
    # setup ssh server
    apt-get install openssh-server
    update-rc.d -f ssh remove
    update-rc.d -f ssh defaults
    rm /etc/ssh/ssh_host_*
    dpkg-reconfigure openssh-server
    service ssh restart

Features
--------

* Supports dpkg cache, so you won't wait after the first run of this software
* Supports multiple linux distributions, such Debian, Arch, or extended by you


That's all. Have fun!
