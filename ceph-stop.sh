#!/bin/sh

for i in 1 2 3 4 -admin ; 
do 
	virsh shutdown ceph$i;
done

