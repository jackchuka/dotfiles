# make directories
echo "Creating directories..."

if [ -e $start_dir/directories ]; then
	echoval $start_dir/directories | xargs -L 1 mkdir -p
fi
