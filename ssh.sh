# setup .ssh/config
echo "Installing ssh config"

if [ ! -d ~/.ssh ]; then
  mkdir ~/.ssh
  echo "Include ~/Dropbox/sync/ssh/conf/*" > ~/.ssh/config
else
  echo "ssh folder exists. skipping..."
fi
