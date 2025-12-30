#!/usr/bin/env bash

## VAR
COLOR_BACKUP="\e[1m"
COLOR_INSTALL="\e[1;21m"
COLOR_SYNC="\e[0;92m"
COLOR_WARNING="\e[0;93m"
COLOR_FAINTED="\e[2m"
RESET="\e[0m"

## FILES
ZSHRC="$HOME/.zshrc"
ZPROFILE="$HOME/.zprofile"
STARSHIP="$HOME/.config/starship.toml"
ZIMRC="$HOME/.zimrc"
ITERM_SCRIPT=$HOME/Library/Application\ Support/iTerm2/Scripts/AutoLaunch/
ITERM_THEMES="$HOME/.config/iterm2/Colors_preset/"
TMUX="$HOME/.tmux.conf"
VIM="$HOME/.vimrc"
VIM_THEME="$HOME/.vim/colors/"

## LOG FUNCTION
log_backup() { printf "${COLOR_BACKUP}========= $1 ========== ${RESET}\n"; }
log_install() { printf "${COLOR_INSTALL}========= $1 ========== ${RESET}\n"; }
log_warning() { printf "${COLOR_WARNING}[+] $1 ${COLOR_FAINTED}\n"; }
log() { printf "${COLOR_SYNC}[+] $1 ${RESET}\n"; }


## INSTALL MODE
function install() {
    log_install "Synchronisation starting - [Install Mode]"
    cp ./zsh/.zshrc $ZSHRC && log "Copying $ZSHRC"
    cp ./zsh/.zprofile $ZPROFILE && log "Copying $ZPROFILE"
    cp ./starship/starship.toml $STARSHIP  && log "Copying $STARSHIP"
    cp ./zim/.zimrc $ZIMRC && log "Copying $ZIMRC"
    cp ./iTerm2/* "$ITERM_SCRIPT"  && log "Copying $ITERM_SCRIPT/*"
    cp ./iTerm2/themes/* "$ITERM_THEMES" && log "Copying $ITERM_THEMES/*"   # Requires directory: ITERM_THEMES
    cp ./tmux/.tmux.conf $TMUX  && log "Copying $TMUX"
    cp ./vim/.vimrc $VIM  && log "Copying $VIM"
    cp ./vim/colors/* "$VIM_THEME"  && log "Copying $VIM_THEME"
    log_install "Synchronisation ending"
}

## BACKUP FILES
function backup() {
    log_backup "Synchronisation starting - [Backup Mode]"
    cp $ZSHRC ./zsh/ && log "Copying $ZSHRC"
    cp $ZPROFILE ./zsh/.zprofile && log "Copying $ZPROFILE"
    cp $STARSHIP ./starship/ && log "Copying $STARSHIP"
    cp $ZIMRC ./zim/ && log "Copying $ZIMRC"
    cp "$ITERM_SCRIPT"* ./iTerm2/ && log "Copying $ITERM_SCRIPT/*"
    cp "$ITERM_THEMES"*.itermcolors ./iTerm2/themes/ && log "Copying $ITERM_THEMES*"
    cp $TMUX ./tmux/ && log "Copying $TMUX"
    cp $VIM ./vim/ && log "Copying $VIM"
    cp "$VIM_THEME"* ./vim/colors/ && log "Copying $VIM_THEME"
    log_backup "Synchronisation ending"
}

if [[ $1 == "--install" ]]; then
    install 
elif [[ $1 == "--sync" ]]; then
    backup
else
    backup
fi
