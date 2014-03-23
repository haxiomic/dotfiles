########## User Specific Config ########## 
P="$HOME/Projects"
PROJECTS=$P

EXTRA_BASH_FILES="$HOME/.bash_scripts"
EDITOR_OF_CHOICE="Sublime Text 3"

# Shortcuts to my Code folder in my home directory
alias haxedir="cd /usr/lib/haxe"
alias lmac="lime test mac"
alias lflash="lime test flash"
alias lhtml="lime test html5"
alias lios="lime test ios"
if [ -d $PROJECTS ]; then
	alias p="cd ~/Projects"
fi

##########################################

### Aliases
# Open specified files in Sublime Text
# "s ." will open the current directory in Sublime
alias s='open -a "$EDITOR_OF_CHOICE"'
alias o='open '

# Color LS
ls="ls" #install coreutils for gls and better ls coloring support
if [ $ls == "ls" ]; then
	colorflag="-G"
else
	colorflag="--color"
fi
alias ls="command ${ls} ${colorflag}"
alias l="${ls} -lF ${colorflag}" # all files, in long format
alias la="${ls} -laF ${colorflag}" # all files inc dotfiles, in long format
alias lsd='${ls} -lF ${colorflag} | grep "^d"' # only directories

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias back="cd -"
alias bk=back

alias desktop="cd ~/Desktop"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Colored up cat!
# You must install Pygments first - "sudo easy_install Pygments"
alias c='pygmentize -O style=monokai -f console256 -g'

# Git 
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gca='git commit -a -m' # requires you to type a commit message
alias gp='git push'
alias testcolors='test_terminal_256_colors_tput'

#Finder
alias show='defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder'

#Misc
alias removeExtraBash='rm -rf $EXTRA_BASH_FILES'

### Prompt Colors 
# Modified version of @gf3’s Sexy Bash Prompt 
# (https://github.com/gf3/dotfiles)
# color codes asii http://misc.flogisoft.com/bash/tip_colors_and_formatting
# asii 256 color format is: ”<Esc>[38;5;ColorNumberm” where <Esc> = \033. ColorNumber is the same as tput colors

# Settings
flatColors=true

export CLICOLOR=1
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

#os x ls colors
export LSCOLORS=Gxfxcxdxbxegedabagacad
#linux ls colors (will only work on linux or with something like gls)
#reference http://linux-sxs.org/housekeeping/lscolors.html
if [ $flatColors ]; then
	export LS_COLORS='di=38;5;32:fi=0:ln=38;5;167:or=38;5;251:mi=38;5;251:ex=38;5;124'
fi

if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2> /dev/null; then
		if ! $flatColors; then
			BLACK=$(tput setaf 0)
			RED=$(tput setaf 1)
			GREEN=$(tput setaf 2)
			YELLOW=$(tput setaf 3)
			BLUE=$(tput setaf 4)
			MAGENTA=$(tput setaf 5)
			CYAN=$(tput setaf 6)
			WHITE=$(tput setaf 7)
			BRIGHT_BLACK=$(tput setaf 8)
			BRIGHT_RED=$(tput setaf 9)
			BRIGHT_GREEN=$(tput setaf 10)
			BRIGHT_YELLOW=$(tput setaf 11)
			BRIGHT_BLUE=$(tput setaf 12)
			BRIGHT_MAGENTA=$(tput setaf 13)
			BRIGHT_CYAN=$(tput setaf 14)
			BRIGHT_WHITE=$(tput setaf 15)
		else
			#Flat colors
			BLACK=$(tput setaf 237)
			RED=$(tput setaf 124)
			GREEN=$(tput setaf 35)
			YELLOW=$(tput setaf 214)
			BLUE=$(tput setaf 32)
			MAGENTA=$(tput setaf 91)
			CYAN=$(tput setaf 31)
			WHITE=$(tput setaf 251)
			BRIGHT_BLACK=$(tput setaf 237)
			BRIGHT_RED=$(tput setaf 167)
			BRIGHT_GREEN=$(tput setaf 35)
			BRIGHT_YELLOW=$(tput setaf 220)
			BRIGHT_BLUE=$(tput setaf 33)
			BRIGHT_MAGENTA=$(tput setaf 128)
			BRIGHT_CYAN=$(tput setaf 38)
			BRIGHT_WHITE=$(tput setaf 255)
		fi
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	if ! $flatColors; then
		BLACK='\033[0;30m'  
		RED='\033[0;31m'    
		GREEN='\033[0;32m'  
		YELLOW='\033[0;33m' 
		BLUE='\033[0;34m'   
		MAGENTA='\033[0;35m'
		CYAN='\033[0;36m'   
		WHITE='\033[0;37m'
		BRIGHT_BLACK='\033[1;30m'  
		BRIGHT_RED='\033[1;31m'    
		BRIGHT_GREEN='\033[1;32m'  
		BRIGHT_YELLOW='\033[1;33m' 
		BRIGHT_BLUE='\033[1;34m'   
		BRIGHT_MAGENTA='\033[1;35m'
		BRIGHT_CYAN='\033[1;36m'   
		BRIGHT_WHITE='\033[1;37m'
	else
		#Flat colors
		BLACK='\033[38;5;237m'  
		RED='\033[38;5;124m'    
		GREEN='\033[38;5;35m'  
		YELLOW='\033[38;5;214m' 
		BLUE='\033[38;5;32m'   
		MAGENTA='\033[38;5;91m'
		CYAN='\033[38;5;31m'   
		WHITE='\033[38;5;251m'
		BRIGHT_BLACK='\033[38;5;237m'  
		BRIGHT_RED='\033[38;5;167m'    
		BRIGHT_GREEN='\033[38;5;35m'  
		BRIGHT_YELLOW='\033[38;5;220m' 
		BRIGHT_BLUE='\033[38;5;33m'   
		BRIGHT_MAGENTA='\033[38;5;128m'
		BRIGHT_CYAN='\033[38;5;38m'   
		BRIGHT_WHITE='\033[38;5;255m'
	fi
	BOLD='\033[1mBold'
	RESET='\033[m'
fi

export BLACK
export RED
export GREEN
export YELLOW
export BLUE
export MAGENTA
export CYAN
export WHITE
export BOLD
export RESET
export BRIGHT_BLACK
export BRIGHT_RED
export BRIGHT_GREEN
export BRIGHT_YELLOW
export BRIGHT_BLUE
export BRIGHT_MAGENTA
export BRIGHT_CYAN
export BRIGHT_WHITE

function test_terminal_256_colors_tput ()
{
	x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
	for i in {0..256}; do
		o=00$i;
		echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
	done
}

# Change this symbol to something sweet. 
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⋮ "

export PS1="\[${BOLD}${RED}\]\u \[$WHITE\]\[$RESET\]in\[$BOLD\] \[$CYAN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" \[$RESET\]on\[$BOLD\] \")\[$BRIGHT_MAGENTA\]\$(parse_git_branch)\[$WHITE\] $symbol\[$RESET\]"
export PS2="\[$YELLOW\]→ \[$RESET\]"

### Misc

# Only show the current directory's name in the tab 
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'


# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

#Git autocomplete script
if [ -f $EXTRA_BASH_FILES/git-completion.bash ]; then
 	. $EXTRA_BASH_FILES/git-completion.bash
else
	if [ ! -d $EXTRA_BASH_FILES ]; then
	 	mkdir $EXTRA_BASH_FILES
	fi
	curl https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > $EXTRA_BASH_FILES/git-completion.bash
	echo -e "\n${BOLD}${YELLOW}Git autocomplete installed to $EXTRA_BASH_FILES/git-completion.bash$RESET"
fi

#Install https://github.com/rupa/z
if [ -f $EXTRA_BASH_FILES/z.sh ]; then
 	. $EXTRA_BASH_FILES/z.sh
else
	if [ ! -d $EXTRA_BASH_FILES ]; then
	 	mkdir $EXTRA_BASH_FILES
	fi
	curl https://raw.githubusercontent.com/rupa/z/master/z.sh > $EXTRA_BASH_FILES/z.sh
	curl https://raw.githubusercontent.com/rupa/z/master/z.1 > $EXTRA_BASH_FILES/z.1
	echo -e "\n${BOLD}${YELLOW}Z has been installed, see https://github.com/rupa/z for details$RESET"
fi
