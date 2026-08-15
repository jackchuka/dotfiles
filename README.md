# dotfiles without a single dot

A super lazy programmer's dotfiles, although it's more like a setup script for the Mac OS environment.

## Features

- Installs brew packages via `Brewfile`

- Downloads `zsh` and `prezto`

- Sets `.gitconfig` and `.gitignore_global`

- Creates `~/.ssh/config`

- Creates directories in `directories`

## Get Started

One line, from a fresh Mac:

```sh
curl -fsSL https://raw.githubusercontent.com/jackchuka/dotfiles/master/bootstrap.sh | bash
```

It installs the Xcode Command Line Tools if `git` is missing, clones the repo into
`~/ghq/github.com/jackchuka/dotfiles` (re-running just pulls), and drops you into the
interactive installer.

To run everything without the menu:

```sh
curl -fsSL https://raw.githubusercontent.com/jackchuka/dotfiles/master/bootstrap.sh | bash -s -- all
```

Override the clone location with `DOTFILES_DIR=...`.

<details>
<summary>Manual</summary>

```sh
$ git clone https://github.com/jackchuka/dotfiles.git
$ cd dotfiles
$ make install
```

</details>

Config files are symlinked back to this checkout, so moving or renaming the
directory afterwards breaks them. Anything already at a target path is moved
aside to `<name>.backup` first.

### Available Commands

```
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

#### [ghostty](https://ghostty.org/)

Setups Ghostty config symlink

- `ghostty` -> `$XDG_CONFIG_HOME/ghostty/config`

#### [prezto](https://github.com/sorin-ionescu/prezto)

Downloads prezto and updates `zpreztorc`

Runcoms are symlinked from the clone, except `.zshrc` and `.zpreztorc`, which
are real files copied out of it. Tool installers append to `.zshrc`, and the
clone is third party — anything written there is unversioned and lost on update.

#### zsh

Install zsh and set default shell to zsh

Owns `$HOME/.zshrc`, loading prezto and then `myzshrc` from it

#### [abbr](https://github.com/olets/zsh-abbr)

Registers zsh-abbr abbreviations (git, kubectl, and friends)
