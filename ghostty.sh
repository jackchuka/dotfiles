# setup ghostty config
echo "Setting up Ghostty config"

link_file "$start_dir/ghostty" "${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/config"
