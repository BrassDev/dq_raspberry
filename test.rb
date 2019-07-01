#!/usr/bin/ruby -w

require 'one_wire_thermo.rb'

puts "========== Scanning and then displaying temperature"
for thermo in OneWireThermo.devices
  puts thermo.to_s
end

address = "28-0316859af1ff"
puts "========== Displaying specific devices, given address #{address}"
thermo = OneWireThermo.get_device(address)
if thermo
  puts thermo.to_s
else
  puts "Thermo not found"
end
