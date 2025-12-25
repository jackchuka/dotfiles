# make directories
echo "Creating directories..."

while IFS= read -r dir; do
	dir="$(expand_home_path "$dir")"
	mkdir -p -- "$dir"
done < <(clean_list_file "$start_dir/directories")
