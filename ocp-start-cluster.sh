#!/bin/sh

for i in master1 master2 master3 worker1 worker2
do 
	virsh start ocp4-$i 
done
