# setup herdr app and config
echo "Setting up Herdr"

if [ ! -d "$HOME/Applications/Herdr.app" ]; then
	curl -fsSL https://releases.herdr.dev/app/install.sh | sh
fi

link_file "$start_dir/herdr/keys.json" "$HOME/.config/herdr-app/keys.json"
link_file "$start_dir/herdr/settings.json" "$HOME/.config/herdr-app/settings.json"
link_file "$start_dir/herdr/mods/agent-top" "$HOME/.config/herdr-app/mods/agent-top"
