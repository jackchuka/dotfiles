# setup mouseless config
echo "Setting up Mouseless config"

mouseless_configs="$HOME/Dropbox/sync/mouseless-configs"

# The configs live in Dropbox, not this repo, so they sync across machines.
# Linking a missing source would leave Mouseless following a dangling symlink.
if [ -d "$mouseless_configs" ]; then
	link_file "$mouseless_configs" "$HOME/Library/Application Support/Mouseless/configs"
else
	echo "skipped: $mouseless_configs not found (waiting on Dropbox?)"
fi
