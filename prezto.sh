# install prezto https://github.com/sorin-ionescu/prezto
echo "Installing prezto..."

if ! command_exists zsh; then
	echo "WARN: zsh not found, skipping prezto"
else
	# Prezto's runcom linking needs EXTENDED_GLOB and the :t modifier, so the
	# body has to run under zsh. The installer itself is bash.
	zsh <<-'PREZTO'
		zprefix=${ZDOTDIR:-$HOME}

		if [[ ! -d "$zprefix/.zprezto" ]]; then
			git clone --recursive https://github.com/sorin-ionescu/prezto.git "$zprefix/.zprezto" || exit 1
		fi

		setopt EXTENDED_GLOB
		for rcfile in "$zprefix"/.zprezto/runcoms/^README.md(.N); do
			target="$zprefix/.${rcfile:t}"
			[[ -L "$target" ]] && continue
			if [[ -e "$target" ]]; then
				mv "$target" "$target.backup"
				echo "backed up $target -> $target.backup"
			fi
			ln -s "$rcfile" "$target"
		done

		preztorc="$zprefix/.zprezto/runcoms/zpreztorc"
		sed -i '' "s/theme 'sorin'/theme 'pure'/g" "$preztorc"
		# Not idempotent: rerunning would append another copy of both modules.
		if ! grep -q "'syntax-highlighting'" "$preztorc"; then
			sed -i '' "s/'prompt'/'prompt' 'syntax-highlighting' 'autosuggestions'/g" "$preztorc"
		fi
	PREZTO
fi
