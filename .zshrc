autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{yellow}%~%f %F{red}${vcs_info_msg_0_}%f$ '

export TERMINAL_NAME="zsh"
export WORK_PATH="$HOME/redo"
export PERSONAL_PATH="$HOME/personal"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export SANDBOX='d63a103c90ea03af96b184100625de2aeff60404'

# GENERAL
alias branches='git branches'
alias alias-list='grep '^alias' ~/.${TERMINAL_NAME}rc'
alias copy-vim='cp ~/personal/WorkstationConfigs/.vimrc ~/.vimrc'
alias copy-terminal='cp ~/personal/WorkstationConfigs/.${TERMINAL_NAME}rc ~/.${TERMINAL_NAME}rc'
alias edit-terminal='vim ~/.${TERMINAL_NAME}rc'
alias mock='git cp f0b9f7ebb'
alias lsg='ls | grep'
alias dts='bazel run dt'
alias node-install='bazel run :nodejs_install'
alias npm-res='bazel run tools/npm:resolve'
alias shopify-build='bazel run --compilation_mode=opt redo_shopify app build'
alias shopify-serve='http-server ~/redo/redo/shopify-app/extensions/theme-extension/assets -c2'
alias gl="git log -1"
alias glx="git log"
alias rbf="git fetch && git rb"
alias temporal="bazel run services -- temporal"
alias webhooks="ngrok http localhost:8888"
alias kill-bazel=pkill ^bazel
alias order='bazel run redo/manage:place-order'
alias kill-redo=~/kill-redo-processes.sh

alias work='cd ${WORK_PATH}'
alias personal='cd ${PERSONAL_PATH}'

# Aliases for the joe-custom-git-extension script
alias git-rs='joe-custom-git-extension restore-staged'
alias git-rt='joe-custom-git-extension restore-tracked'
alias git-at='joe-custom-git-extension add-tracked'
alias git-au='joe-custom-git-extension add-untracked'

alias graphql-gen='bazel run "//tools/graphql:gen"'


# WORK STUFF
alias lint='bazel run lint'
alias lint2='bazel run //tools/lint:tslint_test'
alias lint3='bazel run @//redo/server:mongoose_types'
alias run='bazel run services'

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
