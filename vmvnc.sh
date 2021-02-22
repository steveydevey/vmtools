#!/bin/sh

export baseport=$(awk '/remote_display_port_min/ {print $3}' /etc/libvirt/qemu.conf)

list=$(virsh list | awk '/running/ {print $2}')

for i in $list ; do
        thisport=$(virsh vncdisplay ${i})
        echo "$i - $baseport + $thisport"
done

