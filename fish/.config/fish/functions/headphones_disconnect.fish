function headphones_disconnect --wraps='bluetoothctl disconnect 2C:BE:EB:02:A7:62' --description 'alias headphones_disconnect bluetoothctl disconnect 2C:BE:EB:02:A7:62'
  bluetoothctl disconnect 2C:BE:EB:02:A7:62 $argv; 
end
