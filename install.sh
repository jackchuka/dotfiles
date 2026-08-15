#!/usr/bin/env bash

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

script_dir() {
	CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd
}

clean_list_file() {
	local file="$1"
	[ -f "$file" ] || return 0
	sed -e 's/#.*$//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e '/^$/d' "$file"
}

expand_home_path() {
	local path="$1"
	path="${path//\$HOME/$HOME}"
	case "$path" in
	"~") path="$HOME" ;;
	"~/"*) path="$HOME/${path#~/}" ;;
	esac
	printf '%s\n' "$path"
}

link_file() {
	local src="$1" dest="$2" backup n
	if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
		return 0
	fi
	if [ -e "$dest" ] || [ -L "$dest" ]; then
		# Never overwrite an existing backup, it may be the only copy left.
		backup="$dest.backup"
		n=1
		while [ -e "$backup" ] || [ -L "$backup" ]; do
			backup="$dest.backup.$n"
			n=$((n + 1))
		done
		mv "$dest" "$backup"
		echo "backed up $dest -> $backup"
	fi
	mkdir -p "$(dirname "$dest")"
	ln -s "$src" "$dest"
}

run_all() {
	# shellcheck source=./xcode.sh
	. "$start_dir/xcode.sh"
	# shellcheck source=./brew.sh
	. "$start_dir/brew.sh"
	# shellcheck source=./ssh.sh
	. "$start_dir/ssh.sh"
	# shellcheck source=./directories.sh
	. "$start_dir/directories.sh"
	# shellcheck source=./gitconfig.sh
	. "$start_dir/gitconfig.sh"
	# shellcheck source=./aerospace.sh
	. "$start_dir/aerospace.sh"
	# shellcheck source=./ghostty.sh
	. "$start_dir/ghostty.sh"
	# shellcheck source=./prezto.sh
	. "$start_dir/prezto.sh"
	# shellcheck source=./zsh.sh
	. "$start_dir/zsh.sh"
	# shellcheck source=./abbr.sh
	. "$start_dir/abbr.sh"
}

start_dir="$(script_dir)"
# shellcheck source=./options.sh
. "$start_dir/options.sh"

if [ "${1:-}" = "all" ]; then
	run_all
	exit 0
fi

cat <<"EOF"
 ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  
(___)(___)(___)(___)(___)(___)(___)(___)(___)(___)(___)(___)(___) 
  _        ____   __  ____  ____  __  __    ____  ____        _   
 ( \      (    \ /  \(_  _)(  __)(  )(  )  (  __)/ ___)      ( \  
 / /       ) D ((  O ) )(   ) _)  )( / (_/\ ) _) \___ \      / /  
 \_)      (____/ \__/ (__) (__)  (__)\____/(____)(____/      \_)  
 ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  ___  
(___)(___)(___)(___)(___)(___)(___)(___)(___)(___)(___)(___)(___) 
EOF

while true; do
	echo ""
	echo "> Select one option using up/down keys and enter to confirm:"
	echo ""
	options=("all" "xcode" "brew" "ssh" "directories" "gitconfig" "aerospace" "ghostty" "zsh" "prezto" "abbr" "exit")

	select_option "${options[@]}"
	choice=$?
	option=${options[$choice]}
	echo "Executing \"$option\" ..."

	if [ "$option" = "exit" ]; then
		echo "Bye!"
		break
	elif [ "$option" = "all" ]; then
		run_all
	else
		# shellcheck disable=SC1090
		. "$start_dir/$option.sh"
	fi
done
