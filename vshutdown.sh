#!/bin/sh

for i in $(virsh list | awk '/running/ {print $2}' ) 
do 
	virsh shutdown $i 
done
