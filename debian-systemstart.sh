#!/bin/bash
### BEGIN INIT INFO
# Provides:          systemstart
# Required-Start:    mountkernfs
# Required-Stop:
# Default-Start:     S
# Default-Stop:
# Short-Description: Initializes system if possible, such as console output over HDMI, hostname, sshd ca etc.
### END INIT INFO

. /lib/lsb/init-functions

systemstart_check_create_hostname() {
    if [ ! -e "/etc/hostname" ]; then
        mac=`cat /sys/class/net/eth0/address | sed s/://g`
        hostname="debian-$mac"
        log_action_begin_msg "Creating /etc/hostname with $hostname"
#       mount -n -o remount,rw / || echo "Remounting / rw failed"
        echo "$hostname" > /etc/hostname
        hostname "$hostname"
        if ! grep "^127.0.0.1\s*$hostname\s*" /etc/hosts > /dev/null ; then
            sed -i "1i 127.0.0.1\\t$hostname" /etc/hosts
        fi
#       sync || echo "sync failed"
#       mount -n -o remount,ro / || echo "Remounting / ro failed"
    fi
}

systemstart_check_create_sshca() {
    if [ ! -e /etc/ssh/ssh_host_rsa_key ]; then
        log_action_msg "Generating SSH host keys..." || true
        #mount -n -o remount,rw / || echo "Remounting / rw failed"
        # dpkg-reconfigure openssh-server
        ssh-keygen -A
        #sync || echo "sync failed"
        #mount -n -o remount,ro / || echo "Remounting / ro failed"
    fi
}

case "$1" in
    start)
    log_action_begin_msg "Enable console output over HDMI"
    echo "0" > /sys/devices/platform/mesonfb/graphics/fb1/blank

    systemstart_check_create_sshca
    systemstart_check_create_hostname

    log_action_end_msg 0
    ;;

    *)
    echo "Usage: /etc/init.d/$0 start"
    exit 1

esac
