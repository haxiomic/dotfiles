# Haxiomic's ZSH Terminal (automatically installs dependencies)

# fix npm default path, because it doesn't work
export NPM_CONFIG_PREFIX=~/.npm/global
export PATH=$PATH:$NPM_CONFIG_PREFIX/bin
if [ ! -d $NPM_CONFIG_PREFIX ]; then
	echo "Setting npm global path to $NPM_CONFIG_PREFIX"
	mkdir -p $NPM_CONFIG_PREFIX
	sudo chown -R $USER ~/.npm
fi

# Setup
function haxiomic_install_cli_tools() {
	echo "Installing CLI tools"
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
if [ ! -d ".cli-tools" ]; then
	haxiomic_install_cli_tools
fi

# Tools
# git-completion https://www.oliverspryn.com/blog/adding-git-completion-to-zsh
fpath=(~/.cli-tools $fpath)
zstyle ':completion:*:*:git:*' script ~/.cli-tools/git-completion.bash
autoload -Uz compinit && compinit
# other scripts
source ".cli-tools/zsh-z.plugin.zsh"
source ".cli-tools/git-prompt.zsh"

# ZSH Settings
SAVEHIST=0

# Aliases
alias o='open'

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

# Editors
alias v="code"
alias s="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"

# Server
alias serve="alive-server --ignore=.git,node_modules ."

# Git
function git_commit_and_push() {
	if [[ -z "$1" ]] ; then
		echo -e "${WHITE}Empty commit message${RESET}"
		return
	fi
	git commit -a -m "$1"
	git push
}

alias gs='git status'
alias ga='git add'
alias gc='git commit -m' # requires you to type a commit message
alias gcap=git_commit_and_push
alias gpush='git push'
alias gpull='git pull'
alias gdiff='git diff'
alias gopen='git-open' # npm install -g git-open
# zip directory while following .gitignore
# see https://gist.github.com/LeonardoCardoso/6c083b90a8c327d8c82f
function gitzip() { 
	git archive HEAD -o ${PWD##*/}.zip
}

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