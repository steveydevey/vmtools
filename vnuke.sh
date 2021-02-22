#!/bin/sh

echo "nuking $1"
virsh destroy "$1"
virsh undefine "$1"
rm "/vm/$1.qcow2"
