########## User Specific Config ########## 
PROJECTS="$HOME/Projects"

EDITOR_OF_CHOICE="Sublime Text 3"

FLATCOLORS=true	#this sets the terminal's PS1 & 2 colors based on the flat 256 color values given in this file. To let your terminal decide the colors, set to false.
					#use true for non-mac terminals

ENABLE_EXTRA_SCRIPTS=true #enables auto installing and running of extra scripts
EXTRA_SCRIPTS_DIR="$HOME/.bash_scripts"

alias haxedir="cd /usr/lib/haxe"
alias lmac="lime test mac"
alias lflash="lime test flash"
alias lhtml="lime test html5"
alias lios="lime test ios"

##########################################

### Aliases
# Open specified files in Sublime Text
# "s ." will open the current directory in Sublime
P=PROJECTS

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
alias l="${ls} -lF ${colorflag}" # long format
alias la="${ls} -laF ${colorflag}" # all files (including dotfiles), in long format
alias lsd='${ls} -lF ${colorflag} | grep "^d"' # only directories

alias gls='gls --color' #override coreutils gls with colored gls

# Quicker navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias back="cd -"
alias bk=back

alias desktop="cd ~/Desktop"

if [ -d $PROJECTS ]; then
	alias p="cd ~/Projects"
fi

# Enable aliases to be sudo’ed
alias sudo='sudo '

# You must install Pygments first - "sudo easy_install Pygments"
alias highlight='pygmentize -O style=monokai -f console256 -g'

# Git 
alias gs='git status'
alias ga='git add .'
alias gc='git commit -m' # requires you to type a commit message
alias gca='git commit -a -m' # requires you to type a commit message
alias push='git push'
alias pull='git pull'
alias gbrowser='open `git config --get remote.origin.url`'

#Finder
alias show='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

#Misc
alias testColors='test_terminal_256_colors_tput'

#Configure extra scripts
alias trash='. '$EXTRA_SCRIPTS_DIR/trash

_Z_DATA=$EXTRA_SCRIPTS_DIR'/.zdata' #z data file location

### Prompt Colors 
# Modified version of @gf3’s Sexy Bash Prompt 
# (https://github.com/gf3/dotfiles)
# color codes asii http://misc.flogisoft.com/bash/tip_colors_and_formatting
# asii 256 color format is: ”<Esc>[38;5;ColorNumberm” where <Esc> = \033. ColorNumber is the same as tput colors

export CLICOLOR=1
if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM=xterm-256color
fi

BLACK_CODE=0
RED_CODE=1
GREEN_CODE=2
YELLOW_CODE=3
BLUE_CODE=4
MAGENTA_CODE=5
CYAN_CODE=6
WHITE_CODE=7
BRIGHT_BLACK_CODE=8
BRIGHT_RED_CODE=9
BRIGHT_GREEN_CODE=10
BRIGHT_YELLOW_CODE=11
BRIGHT_BLUE_CODE=12
BRIGHT_MAGENTA_CODE=13
BRIGHT_CYAN_CODE=14
BRIGHT_WHITE_CODE=15

if $FLATCOLORS ; then
	BLACK_CODE=237
	RED_CODE=124
	GREEN_CODE=35
	YELLOW_CODE=214
	BLUE_CODE=32
	MAGENTA_CODE=91
	CYAN_CODE=31
	WHITE_CODE=251
	BRIGHT_BLACK_CODE=237
	BRIGHT_RED_CODE=167
	BRIGHT_GREEN_CODE=35
	BRIGHT_YELLOW_CODE=220
	BRIGHT_BLUE_CODE=33
	BRIGHT_MAGENTA_CODE=128
	BRIGHT_CYAN_CODE=38
	BRIGHT_WHITE_CODE=255
fi

#os x ls colors
export LSCOLORS=Gxfxcxdxbxegedabagacad

#linux ls colors (will only work on linux or with something like gls)
#reference http://linux-sxs.org/housekeeping/lscolors.html
if $FLATCOLORS ; then
	export LS_COLORS='di=38;5;'$CYAN_CODE':fi=0:ln=38;5;'$BRIGHT_MAGENTA_CODE':or=38;5;'$WHITE_CODE':mi=38;5;'$WHITE_CODE':ex=38;5;'$BRIGHT_RED_CODE
fi

#Formatting is given by two different methods for compatibility
if tput setaf 1 &> /dev/null; then
	tput sgr0
	if [[ $(tput colors) -ge 256 ]] 2> /dev/null; then
		BLACK=$(tput setaf $BLACK_CODE)
		RED=$(tput setaf $RED_CODE)
		GREEN=$(tput setaf $GREEN_CODE)
		YELLOW=$(tput setaf $YELLOW_CODE)
		BLUE=$(tput setaf $BLUE_CODE)
		MAGENTA=$(tput setaf $MAGENTA_CODE)
		CYAN=$(tput setaf $CYAN_CODE)
		WHITE=$(tput setaf $WHITE_CODE)
		BRIGHT_BLACK=$(tput setaf $BRIGHT_BLACK_CODE)
		BRIGHT_RED=$(tput setaf $BRIGHT_RED_CODE)
		BRIGHT_GREEN=$(tput setaf $BRIGHT_GREEN_CODE)
		BRIGHT_YELLOW=$(tput setaf $BRIGHT_YELLOW_CODE)
		BRIGHT_BLUE=$(tput setaf $BRIGHT_BLUE_CODE)
		BRIGHT_MAGENTA=$(tput setaf $BRIGHT_MAGENTA_CODE)
		BRIGHT_CYAN=$(tput setaf $BRIGHT_CYAN_CODE)
		BRIGHT_WHITE=$(tput setaf $BRIGHT_WHITE_CODE)
	fi
	BOLD=$(tput bold)
	RESET=$(tput sgr0)
else
	#Flat colors
	BLACK='\033[38;5;'$BLACK_CODE'm'  
	RED='\033[38;5;'$RED_CODE'm'    
	GREEN='\033[38;5;'$GREEN_CODE'm'  
	YELLOW='\033[38;5;'$YELLOW_CODE'm' 
	BLUE='\033[38;5;'$BLUE_CODE'm'   
	MAGENTA='\033[38;5;'$MAGENTA_CODE'm'
	CYAN='\033[38;5;'$CYAN_CODE'm'   
	WHITE='\033[38;5;'$WHITE_CODE'm'
	BRIGHT_BLACK='\033[38;5;'$BRIGHT_BLACK_CODE'm'  
	BRIGHT_RED='\033[38;5;'$BRIGHT_RED_CODE'm'    
	BRIGHT_GREEN='\033[38;5;'$BRIGHT_GREEN_CODE'm'  
	BRIGHT_YELLOW='\033[38;5;'$BRIGHT_YELLOW_CODE'm' 
	BRIGHT_BLUE='\033[38;5;'$BRIGHT_BLUE_CODE'm'   
	BRIGHT_MAGENTA='\033[38;5;'$BRIGHT_MAGENTA_CODE'm'
	BRIGHT_CYAN='\033[38;5;'$BRIGHT_CYAN_CODE'm'   
	BRIGHT_WHITE='\033[38;5;'$BRIGHT_WHITE_CODE'm'

	BOLD='\033[1m'
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
export BRIGHT_BLACK
export BRIGHT_RED
export BRIGHT_GREEN
export BRIGHT_YELLOW
export BRIGHT_BLUE
export BRIGHT_MAGENTA
export BRIGHT_CYAN
export BRIGHT_WHITE
export BOLD
export RESET

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

export PS1="\[${BOLD}${RED}\]\u \[$WHITE\]in \[$CYAN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$BRIGHT_MAGENTA\]\$(parse_git_branch)\[$WHITE\] $symbol\[$RESET\]"
export PS2="\[$RED\]→ \[$RESET\]"

### Misc

# Only show the current directory's name in the tab 
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'


#### Git tools ####
# gitsetup <repo-url>
function gitsetup()
{
	if [[ -z "$1" ]] ; then
		echo -e "${WHITE}Empty repository URL, usage is: gitsetup <repo-url>${RESET}"
		return
	fi
	git init
	git add *
	git commit -m "initial commit"
	git remote add origin $1
	git push -u origin master
}

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}


#### Extra scripts ####
if $ENABLE_EXTRA_SCRIPTS; then
	RESTART_MESSAGE=false
	#Git autocomplete script
	if [ -f $EXTRA_SCRIPTS_DIR/git-completion.bash ]; then
	 	. $EXTRA_SCRIPTS_DIR/git-completion.bash
	else
		echo -e "\n${BOLD}${YELLOW}Installing git autocomplete${RESET}"
		if [ ! -d $EXTRA_SCRIPTS_DIR ]; then
		 	mkdir $EXTRA_SCRIPTS_DIR
		fi
		curl --silent https://raw.github.com/git/git/master/contrib/completion/git-completion.bash > $EXTRA_SCRIPTS_DIR/git-completion.bash
		echo -e "${BOLD}${YELLOW}Git autocomplete installed to $EXTRA_SCRIPTS_DIR/git-completion.bash${RESET}"
		RESTART_MESSAGE=true
	fi

	#Install https://github.com/rupa/z
	if [ -f $EXTRA_SCRIPTS_DIR/z.sh ]; then
	 	. $EXTRA_SCRIPTS_DIR/z.sh
	else
		echo -e "\n${BOLD}${YELLOW}Installing Z$RESET"
		if [ ! -d $EXTRA_SCRIPTS_DIR ]; then
		 	mkdir $EXTRA_SCRIPTS_DIR
		fi
		curl --silent https://raw.githubusercontent.com/rupa/z/master/z.sh > $EXTRA_SCRIPTS_DIR/z.sh
		curl --silent https://raw.githubusercontent.com/rupa/z/master/z.1 > $EXTRA_SCRIPTS_DIR/z.1
		ln -sf $EXTRA_SCRIPTS_DIR/z.1 /usr/local/share/man/man1/z.1
		echo -e "${BOLD}${YELLOW}Z has been installed to $EXTRA_SCRIPTS_DIR/z.sh, see 'man z' for details${RESET}"
		RESTART_MESSAGE=true
	fi

	#Install trash
	if [ ! -f $EXTRA_SCRIPTS_DIR/trash ]; then
		echo -e "\n${BOLD}${YELLOW}Installing trash$RESET"
		if [ ! -d $EXTRA_SCRIPTS_DIR ]; then
		 	mkdir $EXTRA_SCRIPTS_DIR
		fi
		curl --silent https://raw.githubusercontent.com/morgant/tools-osx/master/src/trash > $EXTRA_SCRIPTS_DIR/trash
		echo -e "${BOLD}${YELLOW}Trash has been installed to $EXTRA_SCRIPTS_DIR/trash, see https://github.com/morgant/tools-osx${RESET}"
		RESTART_MESSAGE=true
	fi

	if $RESTART_MESSAGE; then
		echo -e "\n${BOLD}${RED}Restart terminal for changes to take effect${RESET}\n"
	fi
fi

function deleteExtraBashScripts()
{
	#remove z sym link
	if [ -h /usr/local/share/man/man1/z.1 ]; then
		rm  /usr/local/share/man/man1/z.1
	fi

	if [ ! -d $EXTRA_SCRIPTS_DIR ]; then
		echo -e "${BOLD}${GREEN}Nothing to remove${RESET}"
		return
	fi
	rm -rf $EXTRA_SCRIPTS_DIR
	echo -e "${BOLD}${YELLOW}Deleted extra bash scripts${RESET}"
}
