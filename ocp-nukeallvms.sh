#!/bin/sh

for i in master1 master2 master3 bootstrap worker1 worker2
do 
	virsh destroy ocp4-$i 
	virsh undefine ocp4-$i 
	rm /vm/ocp4-${i}.qcow2
done
