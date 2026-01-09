# setup ghostty config
echo "Setting up Ghostty config"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
mkdir -p "$config_dir"
ln -sf "$start_dir/ghostty" "$config_dir/config"
