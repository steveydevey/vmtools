#!/usr/bin/env sh

for i in $(virsh list --all| grep -v '\-\-' | grep -v Name | awk '{print $2}'); do 
	echo $i 
	virsh domiflist $i
	
done
