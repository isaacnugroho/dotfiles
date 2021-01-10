#!/usr/bin/bash

_awesome_pid=$(ps -C awesome -o pid --no-headers)
_key=$(basename "$0" .sh)
_check_file="$XDG_RUNTIME_DIR/awesome-autorun-$_key"

if [[ -e "$_check_file" ]]; then
  _prev_pid=$(cat "$_check_file")
  if [[ "$_prev_pid" == "$_awesome_pid" ]]; then
    exit
  fi
fi
echo "$_awesome_pid" > "$_check_file"

sleep 3

xscreensaver -no-splash &
