##########  		 Config 	    ##########
SCRIPTS_DIR="$HOME/.bash_scripts"
EXTRA_SCRIPTS_DIR=$SCRIPTS_DIR/"additional"

EDITOR_OF_CHOICE="Sublime Text*.app"

FORCE_COLORS=false	#if false the terminal app handles the palette, when true, the color values are set by this script

INSTALL_EXTRA_SCRIPTS=true #enables auto installing and running of extra scripts

##############################################

### Aliases
# Open specified files in Sublime Text
# "s" or s ." will open the current directory in Sublime

_EDITOR_APP_LOCATION="`find /Applications/ -maxdepth 1 -type d -name "$EDITOR_OF_CHOICE" -print -quit`"

alias s=_auto_open_editor
function _auto_open_editor(){
	if [[ -z "$1" ]] ; then
		open -a "$_EDITOR_APP_LOCATION" .
		return
	fi
	open -a "$_EDITOR_APP_LOCATION" "$1"
}

alias o=_auto_open
function _auto_open(){
	if [[ -z "$1" ]] ; then
		open .
		return
	fi
	open "$1"
}

function si() #open editor with the result of a function, usage: si git diff
{
	eval $@ | col -b | open -a "$_EDITOR_APP_LOCATION" -f
}

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

alias gls='gls --color' #override coreutils gls with colored gls

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

# You must install Pygments first - "sudo easy_install Pygments"
alias highlight='pygmentize -O style=monokai -f console256 -g'

# Git
alias gs='git status'
alias ga='git add'
alias gaa='git add .' # git add all
alias gc='git commit -m' # requires you to type a commit message
alias gca='git commit -a -m' # requires you to type a commit message
alias gcap=git_commit_and_push
alias gpush='git push'
alias gpull='git pull'
alias gdiff='git diff'
alias gsetup=git_quick_setup
alias gmaster='git checkout master'
alias gpages='git checkout gh-pages'
alias gopen=$EXTRA_SCRIPTS_DIR/'git-open'
alias git-open=$EXTRA_SCRIPTS_DIR/'git-open'

# zip directory while following .gitignore
alias gitzip="git archive HEAD -o "


#Finder
alias show='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
alias hide='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

#Misc
function sman() #open manual in $EDITOR_OF_CHOICE
{
	man $1 | col -b | open -a "$_EDITOR_APP_LOCATION" -f
}
alias testColors='_test_terminal_256_colors_tput'

#Configure extra scripts
alias trash='. '$EXTRA_SCRIPTS_DIR/trash

_Z_DATA=$EXTRA_SCRIPTS_DIR/zdata #z data file location

### Prompt Colors
# Modified version of @gf3’s Sexy Bash Prompt
# (https://github.com/gf3/dotfiles)
# color codes asii http://misc.flogisoft.com/bash/tip_colors_and_formatting
# asii 256 color format is: ”<Esc>[38;5;ColorNumberm” where <Esc> = \033. ColorNumber is the same as tput colors

export CLICOLOR=1

SUPPORTS_256=false
if [[ $- == *i* ]]
then
	if [[ $(tput colors) -ge 256 ]] ; then
		SUPPORTS_256=true
	fi
fi

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

if $FORCE_COLORS && $SUPPORTS_256 ; then
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
export LS_COLORS='di=38;5;'$CYAN_CODE':fi=0:ln=38;5;'$BRIGHT_MAGENTA_CODE':or=38;5;'$WHITE_CODE':mi=38;5;'$WHITE_CODE':ex=38;5;'$BRIGHT_RED_CODE

#formatting is given by two different methods for compatibility
if [[ $- == *i* ]]
then

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
		#no tput
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

function _test_terminal_256_colors_tput ()
{
	x=`tput op` y=`printf %$((${COLUMNS}-6))s`;
	for i in {0..256}; do
		o=00$i;
		echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;
	done
}

#### Git tools ####
#gcap <message>
function git_commit_and_push()
{
	if [[ -z "$1" ]] ; then
		echo -e "${WHITE}Empty commit message${RESET}"
		return
	fi
	git commit -a -m "$1"
	git push
}

# gitsetup <repo-url>
function git_quick_setup()
{
	if [[ -z "$1" ]] ; then
		echo -e "${WHITE}Empty repository URL, usage is: gitsetup <repo-url>${RESET}"
		return
	fi
	#make sure there's at lease one file
	touch .gitignore
	touch README.md
	#init git and push initial commit
	git init
	git add *
	git commit -m "Initial commit"
	git remote add origin $1
	git push -u origin master
}

# Git branch details
function parse_git_dirty() {
	[[ $(git status 2> /dev/null | tail -n1) != *"working tree clean"* ]] && echo "*"
}
function parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}


# Change this symbol to something sweet.
# (http://en.wikipedia.org/wiki/Unicode_symbols)
symbol="⋮ "

export PS1="\[${BOLD}${RED}\]\u \[$WHITE\]in \[$CYAN\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$BRIGHT_MAGENTA\]\$(parse_git_branch) \[$WHITE\]$symbol\[$RESET\]"
export PS2="\[$RED\]→ \[$RESET\]"

# Only show the current directory's name in the tab
export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'


# Quick webserver with the serve command
alias serve=_start_server_on_free_port
alias server=serve

function _start_server_on_free_port(){
	#start a server with tapio/live-server, python or a ruby http server

	# kill all jobs on exit
	trap 'trap - SIGINT SIGTERM EXIT && kill $(jobs -pr) && echo ${BOLD}${BRIGHT_WHITE}Subprocesses killed, press enter to continue${RESET}' SIGINT SIGTERM EXIT

	#increment until free port or 9999
	{
		for (( PORT = 8080 ; PORT <= 9999 ; PORT++ )); do
			R=$(lsof -iTCP:$PORT)
			if [ ! "$R" ]; then break; fi
		done
	} &> /dev/null

	#background jobs:
	#start scss auto compile if scss folder exists
	{
		if type scss >/dev/null 2>&1; then #check scss command exists
			[ -d "./scss" ] && {
				# determine compile-to folder
				CSS_FOLDER="css"
				{
					[ -d "./css" ] && CSS_FOLDER="css"
				} || {
					[ -d "./style" ] && CSS_FOLDER="style"
				} || {
					[ -d "./styles" ] && CSS_FOLDER="styles"
				}
				sass --watch scss:$CSS_FOLDER
			}
		fi
	} &

	#open url when server running
	{
		INTERVAL=0.4 #seconds
		MAX_TRIES=30

		sleep $INTERVAL;

		for (( N = 0 ; N < MAX_TRIES ; N++ )); do #limit attempts
			#is server running
			R=$(lsof -iTCP:$PORT)
			if [ "$R" ]; then
				break;
			fi
			sleep $INTERVAL;
		done

		#server is running
		# if [ -f "index.html" ]; then
			# open http://127.0.0.1:$PORT/index.html
		# else
			# open http://127.0.0.1:$PORT
		# fi

		echo -e "\n${BOLD}${BRIGHT_WHITE} - Press enter to terminate - ${RESET}" &
	} &

	#start server
	if type live-server >/dev/null 2>&1; then #https://github.com/tapio/live-server
		live-server --port=$PORT --ignore=.git,node_modules . &

	elif type npm >/dev/null 2>&1; then
		read -p "Install tapio/live-server with npm? (Globally) [y/N] " -n 1 -r

		if [[ $REPLY =~ ^[Yy]$ ]]; then
		    sudo npm install live-server -g

		    live-server --port=$PORT --ignore=.git,node_modules . &
		fi

	elif type python >/dev/null 2>&1; then
		#use a basic python server
		PYTHON_EDITION=$(python -c 'import sys;import re;print int(re.compile("\d+").findall(sys.version)[0]);')
		if (( PYTHON_EDITION < 3 )); then
			#python 2
			python -m SimpleHTTPServer $PORT &
		else
			#python 3
			python -m http.server &
		fi
	else
		#ruby server
		ruby -run -e httpd . -p $PORT &
	fi

	#wait for enter	key
	read

	#on shutdown:
	#kill any active jobs
	{
		R=$(jobs -p)
		disown -a #disown any background jobs to prevent messages when killed
		echo $R | xargs kill -15
	} &> /dev/null
}


#### Extra scripts
function install_extra_bash_script(){
	SCRIPT_NAME=$1
	SCRIPT_URL=$2
	SCRIPT_SEE=$3
	if [ ! -f $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME ]; then
		echo -e "\n${BOLD}${YELLOW}Installing ${SCRIPT_NAME}${RESET}"
		if [ ! -d $EXTRA_SCRIPTS_DIR ]; then
		 	mkdir -p $EXTRA_SCRIPTS_DIR
		fi
		if curl --silent -1 $SCRIPT_URL -f -o $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME; then
		#if curl --silent -ssl3 $SCRIPT_URL -f -o $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME; then
			chmod a+x $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME
			echo -e "${BOLD}${GREEN}${SCRIPT_NAME} has been installed to $EXTRA_SCRIPTS_DIR/${SCRIPT_NAME},\nsee "$SCRIPT_SEE"${RESET}"
			RESTART_MESSAGE=true
			true
		else
			echo -e "${BOLD}${RED}${SCRIPT_NAME} failed to be installed; check URL is correct: '${SCRIPT_URL}'${RESET}"
			false
		fi
	else
		true #script already exists
	fi
}

function delete_extra_bash_scripts()
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


if $INSTALL_EXTRA_SCRIPTS; then
	RESTART_MESSAGE=false
	#Git autocomplete script
	SCRIPT_NAME='git-completion.bash'
	SCRIPT_URL='https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash'
	SCRIPT_SEE='https://github.com/git/git/tree/master/contrib'
	if [ -f $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME ]; then
	 	. $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME
	else
		install_extra_bash_script "$SCRIPT_NAME" "$SCRIPT_URL" "$SCRIPT_SEE"
	fi

	#Install https://github.com/rupa/z
	SCRIPT_NAME='z.sh'
	SCRIPT_URL='https://raw.githubusercontent.com/rupa/z/master/z.sh'
	SCRIPT_SEE="'man z' for details"
	if [ -f $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME ]; then
	 	. $EXTRA_SCRIPTS_DIR/$SCRIPT_NAME
	else
		if install_extra_bash_script "$SCRIPT_NAME" "$SCRIPT_URL" "$SCRIPT_SEE"; then
			if install_extra_bash_script 'z.1' 'https://raw.githubusercontent.com/rupa/z/master/z.1' "$SCRIPT_SEE"; then
				ln -sf $EXTRA_SCRIPTS_DIR/z.1 /usr/local/share/man/man1/z.1
			fi
		fi
	fi

	#Install trash
	SCRIPT_NAME='trash'
	SCRIPT_URL='https://raw.githubusercontent.com/morgant/tools-osx/master/src/trash'
	SCRIPT_SEE='https://github.com/morgant/tools-osx'
	install_extra_bash_script "$SCRIPT_NAME" "$SCRIPT_URL" "$SCRIPT_SEE"


	#Install git-open
	SCRIPT_NAME='git-open'
	SCRIPT_URL='https://raw.githubusercontent.com/paulirish/git-open/master/git-open'
	SCRIPT_SEE='https://github.com/paulirish/git-open'
	install_extra_bash_script "$SCRIPT_NAME" "$SCRIPT_URL" "$SCRIPT_SEE"


	if $RESTART_MESSAGE; then
		echo -e "\n${BOLD}${WHITE}Restart terminal for changes to take effect${RESET}\n"
	fi

	unset SCRIPT_NAME
	unset SCRIPT_URL
	unset SCRIPT_SEE
fi



# Run user config (overrides default config above)
if [ -f $HOME/.user_config.bash ] ; then
	source $HOME/.user_config.bash
fi