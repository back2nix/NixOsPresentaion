# typeset -U path cdpath fpath manpat

# PROMPT='%F{yellow}%n@%m %1~ %# %f'
# PROMPT='%F{red}%n@%m %1~ %# %f'
# PROMPT='%F{green}%n@%m %1~ %# %f'
# PROMPT='%F{blue}%n@%m %1~ %# %f'
# PROMPT='%F{magenta}%n@%m %1~ %# %f'
PROMPT='%F{blue}NixOS %F{cyan}%n@%m %1~ %# %f'
# PROMPT='%F{white}%n@%m %1~ %# %f'

alias ll='ls -lah'
alias gs='git status'
alias gp='git pull'
alias gd='git diff'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

autoload -Uz compinit
compinit
