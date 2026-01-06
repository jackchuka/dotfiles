# dotfiles without a single dot

A super lazy programmer's dotfiles, although it's more like a setup script for the Mac OS environment.

## Features

- Installs brew packages via `Brewfile`

- Downloads `zsh` and `prezto`

- Sets `.gitconfig` and `.gitignore_global`

- Creates `~/.ssh/config`

- Creates directories in `directories`

## Get Started

```sh
$ git clone https://github.com/jackchuka/dotfiles.git
$ cd dotfiles && chmod 755 install.sh
$ make install
```

### Available Commands

```javascript
all                            Run all setup
help                           Show this help
install                        Run interactive installer
list                           List all options available
```

### Install Options

When you run `make install`, prompt will ask you to select what script to run.

#### xcode

Installs Xcode Command Line Tools

#### [brew](https://brew.sh/)

Installs brew itself and packages specified in `Brewfile`

#### ssh

Creates `~/.ssh/config` (adds an `Include` entry)

#### directories

Creates directories in `directories` file

#### gitconfig

Creates symlinks to $HOME directory

- `gitconfig` -> `$HOME/.gitconfig`

- `gitignore_global` -> `$HOME/.gitignore_global`

#### aerospace

Setups aerospace config symlinks

- `aerospace.toml` -> `$HOME/.config/aerospace/aerospace.toml`

#### zsh

Install zsh and set default shell to zsh

It will also source `myzshrc` in `.zshrc`

#### [prezto](https://github.com/sorin-ionescu/prezto)

Downloads prezto and updates `zpreztorc`
