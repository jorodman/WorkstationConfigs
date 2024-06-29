autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{yellow}%~%f %F{red}${vcs_info_msg_0_}%f$ '

export TERMINAL_NAME="zsh"
export WORK_PATH="$HOME/redo"
export PERSONAL_PATH="$HOME/personal"

# GENERAL
alias branches='git branches'
alias alias-list='grep '^alias' ~/.${TERMINAL_NAME}rc'
alias copy-vim='cp ~/personal/WorkstationConfigs/.vimrc ~/.vimrc'
alias copy-terminal='cp ~/personal/WorkstationConfigs/.${TERMINAL_NAME}rc ~/.${TERMINAL_NAME}rc'
alias edit-terminal='vim ~/.${TERMINAL_NAME}rc'

alias work='cd ${WORK_PATH}'
alias personal='cd ${PERSONAL_PATH}'

# WORK STUFF
alias lint='bazel run lint'
alias run='bazel run services'

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
