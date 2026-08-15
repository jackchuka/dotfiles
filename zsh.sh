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

# .zshrc has to be a real file we own. Tool installers append to it, and prezto
# links it into ~/.zprezto, so anything written here would land as an
# unversioned edit in a third-party clone that git pull overwrites.
zshrc="$HOME/.zshrc"
if [ -L "$zshrc" ]; then
	case "$(readlink "$zshrc")" in
	*/.zprezto/*)
		if [ -e "$zshrc" ] && cp "$zshrc" "$zshrc.owned"; then
			rm "$zshrc"
			mv "$zshrc.owned" "$zshrc"
			echo "migrated $zshrc out of the prezto clone"
		fi
		;;
	esac
fi
touch "$zshrc"

# prezto's zshrc runcom is deliberately not linked (see prezto.sh), so its
# loader lives here instead. It must precede myzshrc, which builds on prezto.
if ! grep -qF '.zprezto/init.zsh' "$zshrc"; then
	# shellcheck disable=SC2016  # ZDOTDIR must stay literal, zsh expands it at startup
	printf '\n%s\n' 'if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi' >>"$zshrc"
fi

if ! grep -qF "$start_dir/myzshrc" "$zshrc"; then
	printf '\n%s\n' "source \"$start_dir/myzshrc\"" >>"$zshrc"
fi
