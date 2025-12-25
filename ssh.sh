# setup .ssh/config
echo "Installing ssh config"

ssh_dir="$HOME/.ssh"
ssh_config="$ssh_dir/config"
include_line="Include ~/Dropbox/sync/ssh/conf/*"

mkdir -p "$ssh_dir"
chmod 700 "$ssh_dir"

touch "$ssh_config"
chmod 600 "$ssh_config"

if ! grep -qxF "$include_line" "$ssh_config"; then
	printf '%s\n' "$include_line" >>"$ssh_config"
fi
