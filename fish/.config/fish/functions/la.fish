function la --wraps=ls --wraps='ls -halv --group-directories-first' --description 'alias la ls -halv --group-directories-first'
  ls -halv --group-directories-first $argv; 
end
