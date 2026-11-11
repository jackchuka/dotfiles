# set default apps
echo "Setting default apps"

# Runs after brew, so dutix and the apps it points at are installed. Apps
# missing from this Mac are skipped. On macOS 26.4+ each changed UTI or URL
# scheme asks for confirmation in a system dialog.
if command_exists dutix; then
	dutix apply "$start_dir/default-apps.yaml" --yes
else
	echo "skipped: dutix not found (run the brew step first)"
fi
