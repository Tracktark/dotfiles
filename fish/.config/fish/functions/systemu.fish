function systemu --wraps='systemctl --user' --description 'alias systemu systemctl --user'
  systemctl --user $argv; 
end
