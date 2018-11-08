# install AppStore apps
echo "Installing AppStore apps..."

if command_exists mas; then
    echoval $start_dir/masfile | xargs -L 1 mas install
fi
