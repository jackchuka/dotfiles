#!/bin/sh

command_exists() {
	type $1 >/dev/null
}

echoval() {
	echo $(eval echo $(cat $1))
}

start_dir=$(pwd)

if [ $1 = "all" ]; then
	source $start_dir/xcode.sh
	source $start_dir/brew.sh
	source $start_dir/directories.sh
	source $start_dir/gitconfig.sh
	source $start_dir/mas.sh
	source $start_dir/zsh.sh
	source $start_dir/prezto.sh
	exit
fi

echo "Select install"
select cmd in "xcode" "brew" "directories" "gitconfig" "mas" "zsh" "prezto" "exit"; do
	case $cmd in
	"xcode")
		source $start_dir/xcode.sh
		;;
	"brew")
		source $start_dir/brew.sh
		;;
	"directories")
		source $start_dir/directories.sh
		;;
	"gitconfig")
		source $start_dir/gitconfig.sh
		;;
	"mas")
		source $start_dir/mas.sh
		;;
	"zsh")
		source $start_dir/zsh.sh
		;;
	"prezto")
		source $start_dir/prezto.sh
		;;
	"exit") exit ;;
	esac
	echo $cmd "done"
done
