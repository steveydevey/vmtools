#!/bin/sh

nodename=bootstrap
mac=52:54:00:2b:8e:7e
cpu=4
ram=8192

virt-install \
	--name=ocp4-$nodename \
	--vcpus=$cpu \
	--ram=$ram \
	--disk path=/vm/ocp4-${nodename}.qcow2,bus=virtio,size=120 \
	--os-variant rhel8.0 \
	--network bridge=brforvms,model=virtio,mac=${mac} \
	--boot menu=on \
	--cdrom /iso/rhcos-installer.x86_64.iso \
	--graphics vnc,listen=0.0.0.0
