#!/usr/bin/env ruby

class String
  def is_number?
      true if Float(self) rescue false
  end
end

vm_Name    = ''
vm_RamUnit = ''
vm_Memory  = ''
vm_Bridge  = ''
vm_Cpus    = ''

uuid = `uuidgen`

#wholemac = `openssl rand -hex 6 | sed 's/\(..\)/\1\:/g; s/.$//'`
wholemac = (1..6).collect { "%02x" % (rand 255) }.join(":")

while vm_Name.empty? do 
  puts "Name for you new VM:"
  vm_Name = gets.chomp
end

while !(vm_RamUnit =~ /G|K|M/) do
  puts "RAM unit (K/M/G) [G]:"
  vm_RamUnit = gets.chomp.upcase[0]
  #pp "vm_RamUnit - #{vm_RamUnit.type}"

  vm_RamUnit = 'G' if vm_RamUnit.nil? || vm_RamUnit.empty?

  puts "#{vm_RamUnit}? Try again (K/M/G)" unless vm_RamUnit =~ /G|K|M/ 
end

while !vm_Memory.is_number? do 
  puts "Memory capacity [1]:"
  vm_Memory = gets.chomp

  vm_Memory = '1' if vm_Memory.empty?

  # TODO Calculate how many real VMs there are on the box, 
  # and/or how many non-oversubscribed are left

  puts "#{vm_Memory} RAM? Try again" unless vm_Memory.is_number?
end

while !vm_Cpus.is_number? do 
  puts "vCPUs [1]:"
  vm_Cpus = gets.chomp

  vm_Cpus = '1' if vm_Cpus.empty?

  puts "#{vm_Cpus} cpus? Try again"  unless vm_Cpus.is_number?
end

while vm_Bridge.empty? do 
  puts "Network Bridge [br0]:"
  vm_Bridge = gets.chomp

  vm_Bridge = 'br0' if vm_Bridge.empty?
end

puts "name:   #{vm_Name}"
puts "unit:   #{vm_RamUnit}"
puts "memory: #{vm_Memory}"
puts "cpus:   #{vm_Cpus}"
puts "bridge: #{vm_Bridge}"
puts "mac:    #{wholemac}"
puts "uuid:   #{uuid}"


puts "
<domain type='kvm'>
  <name>#{vm_Name}</name>
  <uuid>#{uuid}</uuid>
  <memory unit='#{vm_RamUnit}iB'>#{vm_Memory}</memory>
  <currentMemory unit='#{vm_RamUnit}iB'>#{vm_Memory}</currentMemory>
  <vcpu placement='static'>#{vm_Cpus}</vcpu>
  <os>
    <type arch='x86_64'>hvm</type>
    <boot dev='hd'/>
  </os>
  <features>
    <acpi/>
  </features>
  <clock offset='utc'/>
  <on_poweroff>destroy</on_poweroff>
  <on_reboot>restart</on_reboot>
  <on_crash>destroy</on_crash>
  <devices>
    <emulator>/usr/libexec/qemu-kvm</emulator>
    <disk type='file' device='cdrom'>
      <driver name='qemu' type='raw'/>
      <source file='/vm/iso/centos7-min.iso'/>
      <target dev='hdc' bus='ide'/>
      <readonly/>
      <address type='drive' controller='0' bus='1' unit='0'/>
    </disk>
    <disk type='file' device='disk'>
      <driver name='qemu' type='qcow2'/>
      <source file='/vm/#{vm_Name}.qcow2'/>
      <target dev='hda' bus='ide'/>
      <address type='drive' controller='0' bus='0' target='0' unit='0'/>
    </disk>
    <controller type='usb' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x2'/>
    </controller>
    <controller type='pci' index='0' model='pci-root'/>
    <controller type='ide' index='0'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x01' function='0x1'/>
    </controller>
    <interface type='bridge'>
      <mac address='#{wholemac}'/>
      <source bridge='#{vm_Bridge}'/>
      <model type='virtio'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x03' function='0x0'/>
    </interface>
    <serial type='pty'>
      <target port='0'/>
    </serial>
    <console type='pty'>
      <target type='serial' port='0'/>
    </console>
    <input type='mouse' bus='ps2'/>
    <input type='keyboard' bus='ps2'/>
    <graphics type='vnc' port='-1' autoport='yes' listen='0.0.0.0'>
      <listen type='address' address='0.0.0.0'/>
    </graphics>
    <video>
      <model type='cirrus' vram='9216' heads='1'/>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x02' function='0x0'/>
    </video>
    <memballoon model='virtio'>
      <address type='pci' domain='0x0000' bus='0x00' slot='0x04' function='0x0'/>
    </memballoon>
  </devices>
</domain> "
