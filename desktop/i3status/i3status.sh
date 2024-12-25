#!/bin/bash
# Adds the window title to the i3status.

num_title_cols=96

i3status | while :
do
    read line
    id="$(xprop -root | awk '/_NET_ACTIVE_WINDOW\(WINDOW\)/{print $NF}')"
    if [[ -z "$id" ]] || [[ "$id" == "0x0" ]]; then
      name_length=30
    else
      name="$(xprop -id $id -notype WM_NAME | cut -d'"' -f2- | head -c-2)"
      name_length="${#name}"
    fi

    if [[ "$name_length" -lt "$num_title_cols" ]]; then
      padding_length=$(("$num_title_cols" - "$name_length"))
      padding="$(printf %"$padding_length"s)"
      echo "$name$padding $line" || exit 1
    else
      shortened_name="$(echo "$name" | head -c "$(("$num_title_cols" - 4))")"
      echo "$shortened_name...  $line" || exit 1
    fi
done
