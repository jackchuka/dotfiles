#!/bin/sh

command_exists() {
	type $1 >/dev/null
}

echoval() {
	echo $(eval echo $(cat $1))
}

function run_all() {
	source $start_dir/xcode.sh
	source $start_dir/brew.sh
	source $start_dir/directories.sh
	source $start_dir/gitconfig.sh
	source $start_dir/mas.sh
	source $start_dir/zsh.sh
	source $start_dir/prezto.sh
	source $start_dir/anyenv.sh
}

start_dir=$(pwd)
source $start_dir/options.sh

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
	options=("all" "xcode" "brew" "directories" "gitconfig" "mas" "zsh" "prezto" "anyenv" "exit")

	select_option "${options[@]}"
	choice=$?
	option=${options[$choice]}
	echo "Executing \"$option\" ..."

	if [ $option == "exit" ]; then
		echo "Bye!"
		break
	elif [ $option == "all" ]; then
		run_all
	else
		source $start_dir/$option.sh
	fi
done
