#!/bin/sh

kernel=https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/31.20200118.3.0/x86_64/fedora-coreos-31.20200118.3.0-live-kernel-x86_64
initrd=/iso/fedora-coreos-31.20200118.3.0-live-initramfs.x86_64.img
#kernel=isolinux/vmlinuz
#initrd=isolinux/init.rd
kernel_args='ip=dhcp rd.neednet=1 console=tty0 console=ttyS0 coreos.inst.install_dev=/dev/vda coreos.inst.stream=stable coreos.inst.ignition_url=https://dustymabe.com/2020-01-30/auto-login-serial-console-ttyS0.ign'

name=fcos

virt-install --name ${name} \
	--ram 2048 \
	--vcpus 2 \
	--disk path=/vm/${name}.qcow2,bus=virtio,size=20 \
        --network bridge=brforvms \
        --graphics vnc,listen=0.0.0.0 \
        --install kernel=${kernel},initrd=${initrd},kernel_args_overwrite=yes,kernel_args="${kernel_args}"
