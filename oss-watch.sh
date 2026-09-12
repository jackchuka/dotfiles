# setup gh oss-watch config
echo "Setting up gh oss-watch config"

oss_watch_configs="$HOME/Dropbox/sync/gh-oss-watch"

# The watch list and the last-seen cache live in Dropbox, not this repo, so they
# sync across machines and `status` does not re-report the same activity on every
# Mac. Linking a missing source would leave a dangling symlink.
if [ -d "$oss_watch_configs" ]; then
	link_file "$oss_watch_configs" "$HOME/.gh-oss-watch"
else
	echo "skipped: $oss_watch_configs not found (waiting on Dropbox?)"
fi
