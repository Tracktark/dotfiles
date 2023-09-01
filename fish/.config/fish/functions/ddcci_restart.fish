function ddcci_restart --wraps='sudo modprobe -r ddcci && sudo modprobe ddcci' --description 'alias ddcci_restart sudo modprobe -r ddcci && sudo modprobe ddcci'
  sudo modprobe -r ddcci && sudo modprobe ddcci $argv
        
end
