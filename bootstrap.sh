#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${DOTFILES_REPO:-https://github.com/jackchuka/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/ghq/github.com/jackchuka/dotfiles}"

command_exists() {
	command -v "$1" >/dev/null 2>&1
}

ensure_git() {
	command_exists git && return 0

	echo "git not found, installing Xcode Command Line Tools..."
	xcode-select --install >/dev/null 2>&1 || true

	echo "Waiting for the Command Line Tools installer to finish..."
	until command_exists git; do
		sleep 10
	done
}

fetch_repo() {
	if [ -d "$DOTFILES_DIR/.git" ]; then
		echo "Updating $DOTFILES_DIR ..."
		git -C "$DOTFILES_DIR" pull --ff-only
	else
		echo "Cloning into $DOTFILES_DIR ..."
		mkdir -p "$(dirname "$DOTFILES_DIR")"
		git clone "$REPO_URL" "$DOTFILES_DIR"
	fi
}

ensure_git
fetch_repo
chmod 755 "$DOTFILES_DIR/install.sh"

# When piped from curl, stdin is the script itself; the installer needs the terminal.
if { : </dev/tty; } 2>/dev/null; then
	exec "$DOTFILES_DIR/install.sh" "$@" </dev/tty
fi

echo "No terminal available. Run the installer manually:"
echo "  cd $DOTFILES_DIR && make install"
