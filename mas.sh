# install AppStore apps
echo "Installing AppStore apps..."

if command_exists mas; then
	while IFS= read -r line; do
		app_id="${line%%[[:space:]]*}"
		[[ "$app_id" =~ ^[0-9]+$ ]] || continue
		mas install "$app_id"
	done < <(clean_list_file "$start_dir/masfile")
else
	echo "mas not found; run brew setup first"
fi
