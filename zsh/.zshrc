# Start configuration added by Zim Framework install {{{
#
# User configuration sourced by interactive shells
#
# --------------------
# Module configuration
# --------------------

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)


# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZIM_CONFIG_FILE:-${ZDOTDIR:-${HOME}}/.zimrc} ]]; then
  source ${ZIM_HOME}/zimfw.zsh init
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh
# }}} End configuration added by Zim Framework install

# -------------------------- 
# CUSTOM ZSH CONFIGURATION #
# --------------------------
#
# https://olets.dev/posts/my-zshrc-zsh-configuration-annotated/
# https://zsh.sourceforge.io/Doc/

# ---- COMPLETION ---- #
# ⚠️ Handled by zim
# Enable autocompletion
# https://thevaluable.dev/zsh-install-configure-mouseless/
# autoload -U compinit
# compinit


# https://zsh.sourceforge.io/Doc/Release/Options.html#Completion-4
# complete if cursor is within the word
setopt complete_in_word
# show completion menu on successive tab press
setopt auto_menu

# Now, tab does only completion, not expansion
# https://zsh.sourceforge.io/Guide/zshguide06.html
# echo $PWD -> no expansion
bindkey '^i' complete-word
# To enable expansion AND completion
# bindkey '^i' expand-or-complete-prefix

# ---- HISTORY ---- #
# "The file to save the history in when an interactive shell exits."
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
# ⚠️ If quotes, got the error : "locking failed for ~/.zsh_history: no such file or directory"
HISTFILE=$HOME/.zsh_history

# "The maximum number of events stored in the internal history list."
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
HISTSIZE=1100000000

# "The maximum number of history events to save in the history file."
# https://zsh.sourceforge.io/Doc/Release/Parameters.html#Parameters-Used-By-The-Shell
SAVEHIST=1000000000

# Remove older command from the history if a duplicate is to be added.
setopt HIST_REDUCE_BLANKS       # clean-up unnecessary space
setopt HIST_IGNORE_ALL_DUPS     # remove duplicates

# Enable timestamp recording
setopt EXTENDED_HISTORY

# ---- NAVIGATION ---- #
# Enable CTRL+S for history search
set +o flowcontrol

# makes globbing case insensitive
setopt NO_CASE_GLOB

# doesn't beep on ambiguous completions.
setopt NO_LIST_BEEP

# Consider the path chatacter "/" when navigating between words
# /etc/passwd/ -> CTRL + → move to the first "/" instead of the end of the word
WORDCHARS=${WORDCHARS//[\/]}

# Create empty files with a redirection
setopt SH_NULLCMD

# ---- EDITOR ---- #
# Set editor default keymap to emacs (`-e`) or vi (`-v`)
# Don't want the vim shortcuts in my term
bindkey -e

# ---- DIRECTORY STACK ---- #
# ⚠️ Handled by zim environment module
# setopt auto_pushd
# setopt pushd_ignore_dups

# ---- INTERACTIVE COMMENTS ---- #
# ⚠️ Handled by zim environment module
# setopt interactive_comments # pour permettre d'afficher le theme iterm

# ---- HELP builtins ---- #
# Enable the `help` command on zsh builtins
autoload run-help
HELPDIR=/usr/share/zsh/"${ZSH_VERSION}"/help
# alias help=run-help (in the ALIAS section)

# ---- WIRESHARK -----
# export SSLKEYLOGFILE=~/.config/wireshark/.ssl-key.log

# ---- PATH ---- #
PATH=$PATH:~/.local/bin

# ---- ALIAS ---- #
alias dirs='dirs -v'
alias ll='ls -la'
alias help='run-help'
alias grep='grep --color=auto'
alias please='sudo $(fc -ln -1)'

# ---- FUNCTIONS ---- #
# print iterm & vim theme
function print_theme() {
  ITERM_THEME="$1"
  VIM_THEME=$(echo "$1" | tr " " "-").vim
  /usr/libexec/PlistBuddy -c "Print :'Custom Color Presets':'$ITERM_THEME'" ~/Library/Preferences/com.googlecode.iterm2.plist
  ls "$HOME/.config/iterm2/Colors_preset/$ITERM_THEME.itermcolors"
  ls "$HOME/.vim/colors/$VIM_THEME"
}

# delete iterm & vim theme
function delete_theme() {
  ITERM_THEME="$1"
  VIM_THEME=$(echo "$1" | tr " " "-").vim
  /usr/libexec/PlistBuddy -c "Delete :'Custom Color Presets':'$ITERM_THEME'" ~/Library/Preferences/com.googlecode.iterm2.plist
  rm "$HOME/.config/iterm2/Colors_preset/$ITERM_THEME.itermcolors"
  rm "$HOME/.vim/colors/$VIM_THEME"
}

# select a vim theme according to the iterm theme
# ⚠️ check ./iTerm2/random_color.py line 31
function set_vim_theme() {
  alias vim="vim +'colorscheme $1'"
}

# ---- VARIABLES ---- #
export ITERM_THEME_DIR="$HOME/.config/iterm2/Colors_preset/"

# ---- Starship prompt integration (⚠️ must be EOF) ---- #
# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(starship init zsh)"
  }


