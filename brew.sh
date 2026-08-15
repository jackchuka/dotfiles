# BREW
echo "Setting up Homebrew and brew packages..."

if ! command_exists brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

	# The installer only prints the shellenv instructions, it never touches the
	# running shell. Without this, brew stays off PATH for the rest of setup and
	# every brew-dependent step below silently no-ops.
	for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
		if [ -x "$brew_bin" ]; then
			# The shell argument matters: bare shellenv infers zsh here and emits
			# fpath[1,0]= lines that bash cannot parse.
			eval "$("$brew_bin" shellenv bash)"
			break
		fi
	done
fi

if ! command_exists brew; then
	echo "WARN: brew is unavailable, skipping Brewfile"
elif [ ! -f "$start_dir/Brewfile" ]; then
	echo "WARN: no Brewfile at $start_dir, skipping"
else
	# Homebrew 6+ refuses to load non-official taps until trusted, failing the
	# bundle outright. Derive the list from the Brewfile so it stays in sync
	# with what we actually install.
	brewfile_taps=$(grep -oE '^(brew|cask|tap) "[^"]+"' "$start_dir/Brewfile" |
		sed -E 's/^[a-z_]+ "//; s/"$//' |
		awk -F/ 'NF >= 2 { print $1 "/" $2 }' | sort -u)
	if [ -n "$brewfile_taps" ]; then
		# shellcheck disable=SC2086
		brew trust --tap $brewfile_taps
	fi

	brew bundle --file "$start_dir/Brewfile"
fi
