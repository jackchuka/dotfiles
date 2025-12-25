# update to use local zsh
echo "Enabling zsh and zshrc..."

cmd_zsh=""
if command_exists brew; then
	cmd_zsh="$(brew --prefix)/bin/zsh"
fi
if [ -z "$cmd_zsh" ] || [ ! -x "$cmd_zsh" ]; then
	for candidate in /opt/homebrew/bin/zsh /usr/local/bin/zsh /bin/zsh; do
		if [ -x "$candidate" ]; then
			cmd_zsh="$candidate"
			break
		fi
	done
fi

if [ -n "$cmd_zsh" ] && [ "${SHELL:-}" != "$cmd_zsh" ]; then
	if ! grep -qxF "$cmd_zsh" /etc/shells 2>/dev/null; then
		echo "$cmd_zsh" | sudo tee -a /etc/shells >/dev/null
	fi
	chsh -s "$cmd_zsh"
fi

# add myzshrc to home zshrc
zshrc="$HOME/.zshrc"
source_line="source \"$start_dir/myzshrc\""
touch "$zshrc"
if ! grep -qF "$start_dir/myzshrc" "$zshrc"; then
	printf '\n%s\n' "$source_line" >>"$zshrc"
fi
