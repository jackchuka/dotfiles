# setup aerospace config
echo "Setting up AeroSpace config"

config_dir="$HOME/.config/aerospace"
mkdir -p "$config_dir"
ln -sf "$start_dir/aerospace.toml" "$config_dir/aerospace.toml"
