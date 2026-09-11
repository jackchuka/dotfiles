# gpg-agent: cache the signing passphrase in the macOS keychain
echo "Installing gnupg config"

gnupg_dir="$HOME/.gnupg"
agent_conf="$gnupg_dir/gpg-agent.conf"
pinentry="$(brew --prefix)/bin/pinentry-mac"
# ~400 days, long enough that only a keychain entry survives longer
cache_ttl=34560000

mkdir -p "$gnupg_dir"
chmod 700 "$gnupg_dir"

cat >"$agent_conf" <<EOC
pinentry-program $pinentry
default-cache-ttl $cache_ttl
max-cache-ttl $cache_ttl
EOC
chmod 600 "$agent_conf"

gpgconf --kill gpg-agent
gpgconf --launch gpg-agent

if ! gpg --list-secret-keys "$(git config --file "$start_dir/gitconfig" user.signingkey)" >/dev/null 2>&1; then
	echo "  no secret key yet - import it, then sign once and tick \"Save in Keychain\""
fi
