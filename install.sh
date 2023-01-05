#!/bin/sh

command_exists() {
	type "$1" >/dev/null
}

echoval() {
	echo "$(eval echo $(cat $1))"
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
	# shellcheck source=./mas.sh
	. "$start_dir/mas.sh"
	# shellcheck source=./zsh.sh
	. "$start_dir/zsh.sh"
	# shellcheck source=./prezto.sh
	. "$start_dir/prezto.sh"
	# shellcheck source=./anyenv.sh
	. "$start_dir/anyenv.sh"
}

start_dir=$(pwd)
# shellcheck source=./options.sh
. "$start_dir/options.sh"

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
	# shellcheck disable=SC2039
	options=("all" "xcode" "brew" "ssh" "directories" "gitconfig" "mas" "zsh" "prezto" "anyenv" "exit")

	select_option "${options[@]}"
	choice=$?
	# shellcheck disable=SC2039
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
