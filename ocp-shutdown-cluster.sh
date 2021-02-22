#!/bin/sh

for i in master1 master2 master3 bootstrap worker1 worker2
do 
	virsh shutdown ocp4-$i 
done
