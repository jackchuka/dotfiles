# install Apple developer tool
echo "Installing xcode..."

if command_exists xcode-select; then
	xcode-select --install
fi
