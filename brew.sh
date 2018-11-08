# BREW
echo "Setting up Homebrew and brew packages..."

if ! command_exists brew; then
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# install all brew packages
if [ -e $start_dir/Brewfile ] && command_exists brew; then
	brew tap Homebrew/bundle
	brew bundle
fi
