echo "Add configurable default power profiles"

if [[ ! -f ~/.config/omarchy/powerprofiles.env ]]; then
  mkdir -p ~/.config/omarchy
  cp "$OMARCHY_PATH/config/omarchy/powerprofiles.env" ~/.config/omarchy/powerprofiles.env
fi

source $OMARCHY_PATH/install/config/powerprofilesctl-rules.sh
