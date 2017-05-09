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
sleep 2s
notify-send "Empty Trash" "Trash Has Been Emptied"
