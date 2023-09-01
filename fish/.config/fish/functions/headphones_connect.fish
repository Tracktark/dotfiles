function headphones_connect --wraps='bluetoothctl connect 2C:BE:EB:02:A7:62' --description 'alias headphones_connect bluetoothctl connect 2C:BE:EB:02:A7:62'
  bluetoothctl connect 2C:BE:EB:02:A7:62 $argv; 
end
