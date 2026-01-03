#!/bin/bash

## VAR
COLOR_BANNER="\e[1m"
RESET="\e[0m"

## FUNC
log_banner() { printf "${COLOR_BANNER}========= $1 ========== ${RESET}\n"; }

log_banner "System configuration"
read -p "Hostname: " HOSTNAME
sudo scutil --set HostName "$HOSTNAME"
chsh -s /bin/zsh

log_banner "Brew installation"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "export PATH=$PATH:$(brew --prefix)/bin/brew" > $HOME/.zprofile

log_banner "Brew installation packages"
### Utils
brew install wget
# starship requires nerdfont police installation, nerdfont police iterm configuration, configuration file starship.toml
brew install starship
# do `exec zsh` instead of `source ~/.zshrc` to reload zsh configuration or it will cause compinit to be called twice
# `zimfw list` to check zim modules 
brew install --formula zimfw
brew install tmux
brew install ansifilter # recommended for tmux-logging plugin
brew install tlrc # tldr deprecated
brew install mise
brew install htop
brew install ncdu
brew install imagemagick
brew install exiftool
brew install qpdf
brew install git-filter-repo

### Apps
brew install --cask joplin
brew install --cask firefox
brew install --cask visual-studio-code
brew install --cask iterm2
brew install --cask bitwarden

log_banner "Rosetta"
# required to make iterm autolaunch script works
/usr/sbin/softwareupdate --install-rosetta --agree-to-license

log_banner "Font installation"
brew install font-source-code-pro
brew install font-hack
brew install font-menlo
brew install font-fira-code
brew install font-jetbrains-mono
brew install font-fira-code-nerd-font
brew install font-sauce-code-pro-nerd-font

log_banner "Git configuration"
read -p "GITHUB_EMAIL: " GITHUB_EMAIL && git config --global user.email "$GITHUB_EMAIL"
read -p "GITHUB_USERNAME: " GITHUB_USERNAME && git config --global user.name "$GITHUB_USERNAME"

log_banner "Directory creation"
mkdir ~/.local/opt 
mkdir ~/.local/bin # symlink binaries
mkdir ~/.config/iterm2/Colors_preset/

log_banner "PATH"
echo "export PATH=$PATH:~/.local/bin" >> $HOME/.zprofile
echo "ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code .local/bin" >> $HOME/.zprofile

log_banner "VSCode configuration"
### Add code binary to the path
ln -s /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code .local/bin

log_banner "Tmux configuration"
### Tmux plugin manager installation
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

log_banner "Get Personal-Configuration"
git clone https://github.com/Soldat-Ryan/Personal-Configuration.git ~/.local/opt/ && cd ~/.local/opt/Personal-Configuration && ./sync.sh --install

