#!/bin/sh

VMNAME=rhel7friend
VMPATH=/vm/
ISOPATH=/iso/
#TEMPLATE=${VMPATH}rhel-server-7.8-x86_64-kvm.qcow2
TEMPLATE=${ISOPATH}rhel-server-7.8-x86_64-kvm.qcow2
DISKNAME="${VMPATH}${VMNAME}.qcow2"

if [ -a "${DISKNAME}" ] ; then
	echo "sorry, ${DISKNAME} exists"
else
	echo "${DISKNAME} doesn't exist, copying template"
	cp ${TEMPLATE} ${DISKNAME}
fi


#virt-clone -o cent7 -n ${vmname} -f /vm/${vmname}.qcow2
