#!/bin/sh
#
# "$HOME"/bin/bar.sh by milsen
#

quiet_wname() {
  # only use wname of currently focused window if it exists
  WIN=$(pfw)
  [ -z "$(echo "$WIN" | grep -v "0x00000001")" ] || wname "$WIN" | tail -n 69
}

batteries() {
  # get average battery capacity
  BAT0=$(cat /sys/class/power_supply/BAT0/capacity)
  BAT1=$(cat /sys/class/power_supply/BAT1/capacity)
  AVGBAT=$(((BAT0 + BAT1) / 2))
  battery $AVGBAT
}

battery() {
  # if battery is lower than 10%, show it in red, else in green
  if [ $1 -lt 10 ]; then
    echo "%{F#b84747}$1%"
  else
    echo "%{F#518234}$1%"
  fi
}

current_song() {
  # show songtitle in color dependent on whether the song is playing or not
  SONGTITLE="$(mpc -f '[[%artist% - ]%title%]' current | head -c 70)"
  if [ -z "$(mpc status | grep "^\[playing\]")" ]; then
    echo "%{F#686f77} $SONGTITLE"
  else
    echo "%{F-} $SONGTITLE"
  fi
}

volume() {
  # get Mono information of Master device,
  # cut out the volume percent as well as the f/n of "off" or "on",
  # replace the f/n by X/< to make it look like a speaker
  amixer get Master | grep "Mono:" | \
    sed -r "s/.*\[([0-9]+%).*o([fn]).*/<\2 \1/" | \
    tr f "X" | tr n "<"
}

groups() {
  # get group numbers for groups that contain windows
  WINGRPS=$(find ~/.cache/wmrc/groups/*/* | xargs dirname | xargs basename -a | uniq)
  # get string of minuses, each representing a group, with activeness colorcoded
  ACT_GRPS=$(groupstat | sed "s/0/%{F#686f77}-/g" | sed "s/1/%{F#e0925c}-/g")

  # let each - of a group that actually contains a window become *
  for i in $WINGRPS; do
    ACT_GRPS=$(echo "$ACT_GRPS" | sed -r "s/.([ $])/\*\1/$i")
  done

  echo "$ACT_GRPS"
}

loop() {
  while true; do
    echo " $(groups)" \
      "%{F#686f77}|" \
      "%{F-}$(quiet_wname)" \
      "%{r}%{F#686f77} |" \
      "$(current_song)" \
      "%{F#686f77}|" \
      "%{F#e0925c}$(volume)" \
      "%{F#686f77}|" \
      "%{F-}$(batteries)" \
      "%{F#686f77}|" \
      "%{F-}$(date "+%d.%m.  %X") "
    sleep 0.3
  done
}

loop | lemonbar \
  -f "-xos4-terminus-bold-r-normal--20-200-72-72-c-100-iso8859-16" \
  -d -g 1920x40+0+0 -n "lemonbar" -F "#c9ccca" -B "#282a2e"
