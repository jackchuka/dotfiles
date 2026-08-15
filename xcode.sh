# install Apple developer tool
echo "Installing xcode..."

if ! command_exists xcode-select; then
	echo "WARN: xcode-select not found, skipping"
elif xcode-select -p >/dev/null 2>&1; then
	echo "Xcode Command Line Tools already installed"
else
	# --install returns as soon as the GUI installer is launched, so brew.sh
	# would otherwise start building against a missing toolchain.
	xcode-select --install >/dev/null 2>&1 || true
	echo "Waiting for the Command Line Tools installer to finish..."

	xcode_waited=0
	xcode_timeout=1800
	while ! xcode-select -p >/dev/null 2>&1; do
		if [ "$xcode_waited" -ge "$xcode_timeout" ]; then
			echo "WARN: still not installed after $((xcode_timeout / 60))m, continuing anyway"
			break
		fi
		sleep 10
		xcode_waited=$((xcode_waited + 10))
	done

	if xcode-select -p >/dev/null 2>&1; then
		echo "Xcode Command Line Tools installed"
	fi
fi
