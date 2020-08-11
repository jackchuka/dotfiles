# install prezto https://github.com/sorin-ionescu/prezto
echo "Installing prezto..."

if [ ! -d ${ZDOTDIR:-$HOME}/.zprezto ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    # symlink files
    setopt EXTENDED_GLOB
    for rcfile in "${ZDOTDIR:-$HOME}/.zprezto/runcoms/^README.md(.N)"; do
        ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
    done

    # update zpreztorc
    preztorc=${ZDOTDIR:-$HOME}/.zprezto/runcoms/zpreztorc
    sed -i -- "s/theme 'sorin'/theme 'pure'/g" $preztorc
    sed -i -- "s/'prompt'/'prompt' 'syntax-highlighting' 'autosuggestions'/g" $preztorc
fi
