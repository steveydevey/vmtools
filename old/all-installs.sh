#!/bin/sh

nodename=bootstrap
mac=52:54:00:00:0f:88
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

virt-install \
  --name=ocp4-master1   \
  --vcpus=4 \
  --ram=16384 \
  --disk path=/vm/ocp4-master1.qcow2,bus=virtio,size=120   \
  --os-variant rhel8.0 \
  --network bridge=brforvms,model=virtio,mac=52:54:00:91:cb:94 \
  --boot menu=on \
  --cdrom /iso/rhcos-installer.x86_64.iso \
  --graphics vnc,listen=0.0.0.0 

virt-install \
  --name=ocp4-master2   \
  --vcpus=4 \
  --ram=16384 \
  --disk path=/vm/ocp4-master2.qcow2,bus=virtio,size=120   \
  --os-variant rhel8.0 \
  --network bridge=brforvms,model=virtio,mac=52:54:00:fd:da:16 \
  --boot menu=on \
  --cdrom /iso/rhcos-installer.x86_64.iso \
  --graphics vnc,listen=0.0.0.0 

virt-install \
  --name=ocp4-master3   \
  --vcpus=4 \
  --ram=16384 \
  --disk path=/vm/ocp4-master3.qcow2,bus=virtio,size=120   \
  --os-variant rhel8.0 \
  --network bridge=brforvms,model=virtio,mac=52:54:00:80:16:23 \
  --boot menu=on \
  --cdrom /iso/rhcos-installer.x86_64.iso \
  --graphics vnc,listen=0.0.0.0 

virt-install \
  --name=ocp4-worker1   \
  --vcpus=2 \
  --ram=8192  \
  --disk path=/vm/ocp4-worker1.qcow2,bus=virtio,size=120   \
  --os-variant rhel8.0 \
  --network bridge=brforvms,model=virtio,mac=52:54:00:2e:9b:6d \
  --boot menu=on \
  --cdrom /iso/rhcos-installer.x86_64.iso \
  --graphics vnc,listen=0.0.0.0 

virt-install \
  --name=ocp4-worker2   \
  --vcpus=2 \
  --ram=8192  \
  --disk path=/vm/ocp4-worker2.qcow2,bus=virtio,size=120   \
  --os-variant rhel8.0 \
  --network bridge=brforvms,model=virtio,mac=52:54:00:00:0f:88 \
  --boot menu=on \
  --cdrom /iso/rhcos-installer.x86_64.iso \
  --graphics vnc,listen=0.0.0.0 

