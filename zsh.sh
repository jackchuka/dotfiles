# update to use local zsh
echo "Enabling zsh and zshrc..."

cmd_zsh="/usr/local/bin/zsh"
if [ ! $SHELL = $cmd_zsh ] && command_exists $cmd_zsh; then
    echo $cmd_zsh | sudo tee -a /etc/shells
    chsh -s $cmd_zsh
fi

# add myzshrc to home zshrc
if [ -e $HOME/.zshrc ] && ! grep -q $start_dir/myzshrc $HOME/.zshrc; then
    echo "source $start_dir/myzshrc" >> $HOME/.zshrc
fi
