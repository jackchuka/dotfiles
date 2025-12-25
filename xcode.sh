# install Apple developer tool
echo "Installing xcode..."

if command_exists xcode-select; then
	if xcode-select -p >/dev/null 2>&1; then
		echo "Xcode Command Line Tools already installed"
	else
		xcode-select --install
	fi
fi
