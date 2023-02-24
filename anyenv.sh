# Install anyenv
echo "Installing anyenv..."

git clone https://github.com/riywo/anyenv ~/.anyenv
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
