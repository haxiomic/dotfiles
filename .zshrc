# Haxiomic's ZSH Terminal (automatically installs dependencies on first run)

autoload -Uz compinit && compinit
# case insensitive path-completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fix npm default path, because it doesn't work
# export NPM_CONFIG_PREFIX=~/.npm/global
# export PATH=$PATH:$NPM_CONFIG_PREFIX/bin
# if [ ! -d $NPM_CONFIG_PREFIX ]; then
# 	echo "Setting npm global path to $NPM_CONFIG_PREFIX"
# 	mkdir -p $NPM_CONFIG_PREFIX
# 	sudo chown -R $USER ~/.npm
# fi

# Paths
export PATH=$PATH:"/Applications/Sublime Text.app/Contents/SharedSupport/bin"
export PATH=$PATH:"/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Setup
function haxiomic_install_cli_tools() {
	echo "Haxiomic dotfiles: Installing CLI tools"

	# check if npm is installed
	if ! command -v npm &> /dev/null
	then
		echo "\t > Error: npm required; install node.js and npm"
		echo "\t https://nodejs.org/en/download/"
		exit
	fi
	
	cd ~

	mkdir -p ".cli-tools"
	cd ".cli-tools"

	# z jump
	curl https://raw.githubusercontent.com/agkozak/zsh-z/master/zsh-z.plugin.zsh > zsh-z.plugin.zsh
	# git-prompt
	curl https://raw.githubusercontent.com/woefe/git-prompt.zsh/master/git-prompt.zsh > git-prompt.zsh
	# git-completion (both files required)
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash > git-completion.bash
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh > git-completion.zsh
	# git-open
	npm install --global git-open
	# trash
	npm install --global trash-cli
	# alive-server
	npm install --global alive-server

	cd ~
}
if [ ! -d "$HOME/.cli-tools" ]; then
	haxiomic_install_cli_tools
fi

# Tools
# git-completion https://www.oliverspryn.com/blog/adding-git-completion-to-zsh
fpath=($HOME/.cli-tools $fpath)
zstyle ':completion:*:*:git:*' script $HOME/.cli-tools/git-completion.bash
# other scripts
source "$HOME/.cli-tools/zsh-z.plugin.zsh"
source "$HOME/.cli-tools/git-prompt.zsh"

# Aliases
function o(){
	[ -z "$1" ] && open . || open "$1"
}

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias back="cd -"
alias bk=back

# ls
alias ls="ls -G" # color
alias l="ls -lF" # long format
alias la="ls -laF" # all files (including dotfiles), in long format

# Locations
alias p="cd ~/Projects"
alias d="cd ~/Downloads"
alias h="cd ~"
alias dk="cd ~/Desktop"

# Languages
alias py="python3"
alias python="python3"

# Touch python venv, no name needed
function venv() {
	python3 -m venv .venv
	source .venv/bin/activate
}

# Editors
# vscode
function v(){
	[ -z "$1" ] && code . || code "$1"
}
# sublime
function s(){
	[ -z "$1" ] && subl . || subl "$1"
}

# open editor with the result of a function, usage: si git diff
function si() {
	eval $@ | col -b | open -t -f
}

# open man page in editor
function sman() {
	man $1 | col -b | open -t -f
}

# Server
alias serve="alive-server --ignore=.git,node_modules ."

# Git
function git-commit-and-push() {
	if [[ -z "$1" ]] ; then
		echo -e "${WHITE}Empty commit message${RESET}"
		return
	fi
	git commit -a -m "$1"
	git push
}

function git-reset-to-remote() {
	# ask for confirmation
	if read -q "choice?Resetting to remote branch. Are you sure? (Y/y)"; then
		echo ""
		echo ""
		git reset --hard $(git remote)/$(git branch --show-current)
	else
		echo ""
		echo -e "Aborted"
	fi
}

alias g='git'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m' # requires you to type a commit message
alias gcap=git-commit-and-push
alias gpush='git push'
alias gpull='git pull'
alias gdiff='git diff'
alias gopen='git-open' # npm install -g git-open
alias gk='git checkout'
alias gsubmodules='git submodule update --init --recursive'
alias greset=git-reset-to-remote
alias guncommit='git reset --soft HEAD^'
# zip directory while following .gitignore
# see https://gist.github.com/LeonardoCardoso/6c083b90a8c327d8c82f
function gitzip() { 
	git archive HEAD -o ${PWD##*/}.zip
}

# n for npm/pnpm/yarn
function n() {
	if [ -f "yarn.lock" ]; then
		# echo white bold "yarn"
		echo "\e[1;37m> [yarn] <\e[0m"
		yarn $@
	elif [ -f "pnpm-lock.yaml" ]; then
		echo "\e[1;37m> [pnpm] <\e[0m"
		pnpm $@
	else
		echo "\e[1;37m> [npm] <\e[0m"
		npm $@
	fi
}

# randomizes mac address
# this will reset after restart
# may fail with "cannot assign address", try turning it on and off again
function random-mac() {
	MAC=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
	sudo /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -z
	sudo ifconfig en0 ether "$MAC" && echo "new MAC $MAC"
}

alias nr='n run'
alias ni='n install'
alias nbuild='n run build'
alias nstart='n run start'
alias ndev='n run dev'

# git-prompt setup
# see https://github.com/woefe/git-prompt.zsh/blob/master/examples/compact.zsh
ZSH_GIT_PROMPT_SHOW_UPSTREAM="no"

ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_DETACHED="%{$fg_bold[cyan]%}:"
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%{$fg_bold[yellow]%}⟳ "
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%{$fg[red]%})"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}✖"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[green]%}●"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%{$fg[red]%}✚"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%{$fg[blue]%}⚑"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔"

PROMPT='%B%40<..<%~%b$(gitprompt)'
PROMPT+='%(?.%(!.%F{yellow}.%F{cyan}).%F{red}) ❯%f '
RPROMPT=''

# tmp
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/geo/SDKs/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/geo/SDKs/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/geo/SDKs/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/geo/SDKs/google-cloud-sdk/completion.zsh.inc'; fi
# pnpm
export PNPM_HOME="/Users/george/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# AI
alias claude-fun="claude --dangerously-skip-permissions"
alias cf="claude-fun"
. "$HOME/.local/bin/env"

export ANTHROPIC_MODEL="claude-opus-4-1-20250805"