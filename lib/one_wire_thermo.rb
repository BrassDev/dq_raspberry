#!/usr/bin/ruby -w

DEVICE_BASE_DIR = '/sys/bus/w1/devices/'

class OneWireThermo


  ### Instance Initialize ###################################################
  
  def initialize(address)
    @address = address
    @device_file = "#{DEVICE_BASE_DIR}#{address}/w1_slave"
  end

  ### Class Methods #########################################################
  
  def self.scan()
    devices = []
    device_folders = Dir.glob(DEVICE_BASE_DIR + '28*')
    for device_folder in device_folders
      address = device_folder.split('/').last
      devices << OneWireThermo.new(address) 
    end
    return devices
  end

  def self.devices
    @@devices
  end

  def self.get_device(address)
    for device in @@devices
      return device if device.address == address
    end
    return nil
  end

  ### Class Initialization #####################################################
  
  @@devices = scan()

  
  ### Instance Methods #######################################################
  
  def temperature()
    lines = read_raw_lines
    t = lines[1].split("t=")[1]
    return (t.to_f)/1000
  end

  def address
    @address
  end

  def raw_line(line_number)
    if [0,1].include? line_number
      return read_raw_lines[line_number]
    else
      return "Line not found"
    end
  end

  def to_s
    return "Address:      #{self.address}\nTemperature:  #{self.temperature}\nRaw Line 0:   #{self.raw_line(0)}\nRaw Line 1:   #{self.raw_line(1)}\nDevice File:  #{@device_file}"
  end

  ### Private Methods ##########################################################
  
  private
  def read_raw_lines
    lines = File.read(@device_file)
    return lines.split("\n")
  end

  
end





