#!/bin/sh

list=$(virsh list | awk '/running/ {print $2}')

for i in $list ; do 
	thisport=$(virsh vncdisplay ${i})
	echo "$i - $thisport"
done
