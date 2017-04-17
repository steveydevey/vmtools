#!/usr/bin/env ruby

class Vm 
  def getNics(name)
    # get the nic info
    vmname = name
    virshnics_raw = `virsh domiflist #{vmname}`.split("\n")
    virshnics_raw.shift
    virshnics_raw.shift
    virshnics = virshnics_raw
    return virshnics
  end

  def getVnc
    # get vnc info
  end

  def initialize(name, id, status)
    @name=name
    @id=id
    @status=status
    if status == 'running'
      vncport = getVnc()
      @nics = getNics(@name)
      $out_data += [[ @id, @name, @status, @nics]]
    else
      $out_data += [[ @id, @name, @status]]
    end
  end

end
  
virshlist    = `virsh list --all`.split("\n")

# remove the two header lines
virshlist.shift
virshlist.shift

vmList    = virshlist
$out_data  = []

# start the data gathering
vmList.each { |dom| 
  dom_info = dom.split
  dom_id =   dom_info[0]
  dom_name = dom_info[1]
  dom_stat = dom_info[2]
  Vm.new(dom_name, dom_id, dom_stat) 
}

# spit out what we've found
print $out_data
print "\n-------------------\n"
$out_data.each { |vm| 
  print vm.join(" - ") + "\n"
}

