# BREW
echo "Setting up Homebrew and brew packages..."

if ! command_exists brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install all brew packages
if [ -f "$start_dir/Brewfile" ] && command_exists brew; then
	# Homebrew 6+ refuses to load non-official taps until trusted, which would
	# turn an unattended setup into a series of prompts. Derive the list from
	# the Brewfile so it stays in sync with what we actually install.
	brewfile_taps=$(grep -oE '^(brew|cask|tap) "[^"]+"' "$start_dir/Brewfile" |
		sed -E 's/^[a-z_]+ "//; s/"$//' |
		awk -F/ 'NF >= 2 { print $1 "/" $2 }' | sort -u)
	if [ -n "$brewfile_taps" ]; then
		# shellcheck disable=SC2086
		brew trust --tap $brewfile_taps
	fi

	brew bundle --file "$start_dir/Brewfile"
fi
