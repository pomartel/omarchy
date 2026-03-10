if omarchy-battery-present; then
  USER_UID=$(id -u)
  RUN_COMMAND="/usr/bin/runuser -u $USER -- /usr/bin/env HOME=$HOME OMARCHY_PATH=$OMARCHY_PATH XDG_RUNTIME_DIR=/run/user/$USER_UID DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$USER_UID/bus PATH=$OMARCHY_PATH/bin:/usr/local/sbin:/usr/local/bin:/usr/bin /usr/bin/systemd-run --user --quiet --collect $OMARCHY_PATH/bin/omarchy-hook power-source-change"

  cat <<EOF | sudo tee "/etc/udev/rules.d/99-power-source-hook.rules"
SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="0", RUN+="$RUN_COMMAND battery"
SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ATTR{online}=="1", RUN+="$RUN_COMMAND ac"
EOF

  sudo udevadm control --reload
  sudo udevadm trigger --subsystem-match=power_supply
fi
