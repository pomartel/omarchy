echo "Add power source change hooks"

source $OMARCHY_PATH/install/config/power-source-hook-rules.sh

if [[ ! -d ~/.config/omarchy/hooks/power-source-change.d ]]; then
  mkdir -p ~/.config/omarchy/hooks/power-source-change.d
  cp -r "$OMARCHY_PATH/config/omarchy/hooks/power-source-change.d/." ~/.config/omarchy/hooks/power-source-change.d
fi

if [[ -f /etc/udev/rules.d/99-power-profile.rules ]]; then
  sudo rm -f /etc/udev/rules.d/99-power-profile.rules
  sudo udevadm control --reload
fi
