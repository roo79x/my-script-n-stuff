#!/bin/bash
if [ $# -eq 0 ]; then
  rm -rf ~/.local/share/Trash/*/*
else
  for f in "$@"; 
  do
    rm -rf ~/.local/share/Trash/files/"$f"
    rm -rf ~/.local/share/Trash/info/"$f".trashinfo 
  done
fi
sleep 1s
kdialog --passivepopup 'Trash Has Been Emptied' 2
