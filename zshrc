# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git docker-compose)

source $ZSH/oh-my-zsh.sh

############################
# BASIC USER CONFIGURATION #
############################

export EDITOR='vim'

alias zshconfig="vim ~/.zshrc"

# GPG setup to launch agent at start.
export GPG_TTY=$(tty)
gpgconf --launch gpg-agent

# Toggle homebrew path based on whether x86 is used or not.
if uname -m | grep -q 'arm64'; then
  export PATH="/opt/homebrew/bin:$PATH"
else
  export PATH="/usr/local/bin:$PATH"
fi

# Brew env variables.
eval "$(brew shellenv)"

# Use asdf instead of rbenv.
source $(brew --prefix)/opt/asdf/libexec/asdf.sh

# Load config variables from files.
function catconfig {
  cat ~/.config/$1
}

# Bundler
alias be="bundle exec"
alias ber="bundle exec rake"

# Kubernetes
alias k="kubectl"

# Open IntelliJ
function idea {
  open -na "IntelliJ IDEA.app" --args "$@"
}

# Git kaleidescope integration
function gdk {
  git difftool -y -t Kaleidoscope $1
}

alias trim="sed 's/^ *//' | sed 's/ *$//'"
alias serve="python -m SimpleHTTPServer 8000"

# Debugging
# See https://gist.github.com/carlwiedemann/ac9d1c8f58801a9e160ff1b44f16ae39
# Add this file to global gitignore
# # git config --global core.excludesfile ~/.gitignore
function bringdd {
  cp ~/_src/_dd.rb config/initializers
}

alias readdd="touch /tmp/debug.log && tail -f /tmp/debug.log"
alias wipedd="cat /dev/null > /tmp/debug.log"

############################
# CHECKR USER CONFIGURATION #
############################

# Teleport
export TELEPORT_PROXY="heimdallr.checkrhq.net"
export TELEPORT_AUTH="gitlab"
export TSH_USER=carl.wiedemann

# Gitlab
export GITLAB_PAT=$(catconfig GITLAB_PAT)

# Login to container registry so that Docker can pull images
function checkr_docker_login {
  echo ${GITLAB_PAT} | docker login -u${USER} gitlab-registry.checkrhq.net --password-stdin
}

# Ruby gems & gemfury
export RUBYGEMS_API_KEY=$(catconfig RUBYGEMS_API_KEY)
export BUNDLE_GEM__FURY__IO=$(catconfig BUNDLE_GEM__FURY__IO)
export GEM_FURY_PUSH_TOKEN=$(catconfig GEM_FURY_PUSH_TOKEN)

# Open a merge request
function mr {
  BRANCH=$(git rev-parse --abbrev-ref HEAD)
  REPO=$(basename $PWD)
  GROUP=$(git remote get-url origin | cut -d : -f 2 | xargs dirname)
  open "https://gitlab.checkrhq.net/$GROUP/$REPO/-/merge_requests/new?merge_request%5Bsource_branch%5D=$BRANCH"
}

# Tests in monolith
alias testme="VERBOSE_TEST_REPORTS=1 bundle exec m"

###########
# ENDINGS #
###########

# Starship
eval "$(starship init zsh)"

# TMUX setup, see https://koenwoortman.com/tmux-sessions-should-be-nested-with-care-unset-tmux-to-force/
tmux has-session -t=main 2> /dev/null

if [[ $? -ne 0 ]]; then
  TMUX='' tmux new-session -d -s "main"
fi

if [[ -z "$TMUX" ]]; then
  tmux attach -t "main"
else
  tmux switch-client -t ""
fi
