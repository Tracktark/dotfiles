function l --wraps='ls -hlv --group-directories-first' --description 'alias l ls -hlv --group-directories-first'
  ls -hlv --group-directories-first $argv; 
end
