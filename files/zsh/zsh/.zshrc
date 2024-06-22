#
# Exports
#
export BROWSER="/var/lib/flatpak/app/com.brave.Browser/x86_64/stable/active/files/brave" 
export ZATHURA_CONFIG=~/.config/zathura/zathurarc

#
# Plugins
#

# Powerlevel10k (frontend)

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source $HOME/.config/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# Autosuggestions
source $HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax Highlighting
source $HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# ASDF
. "$HOME/.asdf/asdf.sh"

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

#
# Functions
#

# Forks execution 
fork() {
  sh -ic "($* &) &>/dev/null"
}

#
# Aliases 
#

# Programs
alias screenshot='fork "maim -o --select | xclip -selection clipboard -t image/png"'

# Shortcuts
alias set_lang_toggle='setxkbmap -option grp:alt_space_toggle us,ru &'
alias tty='fork "alacritty --working-directory "$(readlink -e /proc/"$(pgrep -P "$(xdo pid)" | head -n 1)"/cwd)""'

#
# Start Up
#

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# To remove Powerlevel10k warnings
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

neofetch
