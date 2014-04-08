########## User Specific Config ########## 
PROJECTS="$HOME/Projects"

EDITOR_OF_CHOICE="Sublime Text*.app"

FLATCOLORS=false	#this sets the terminal's PS1 & 2 colors based on the flat 256 color values given in this file. To let your terminal decide the colors, set to false.
					#use true for non-mac terminals

INSTALL_EXTRA_SCRIPTS=true #enables auto installing and running of extra scripts

alias haxedir="cd /usr/lib/haxe"
alias lmac="lime test mac"
alias lflash="lime test flash"
alias lhtml="lime test html5"
alias lios="lime test ios"

function setHaxeVersion(){
	FIND_RESULT="`find /usr/lib/ -type d -maxdepth 1 -name "haxe-*$1"`"
	NUM_RESULTS=`echo "$FIND_RESULT" | wc -l`

	if [[ $NUM_RESULTS -eq 1 ]] && [[ -n $FIND_RESULT ]] ; then

		if [[ ! -d /usr/lib/haxe/lib ]] ; then #make haxe dir & lib if they don't
			sudo mkdir -p /usr/lib/haxe/lib
		fi

		sudo ln -sf $FIND_RESULT/haxe /usr/lib/haxe || return 1
		sudo ln -sf $FIND_RESULT/haxelib /usr/lib/haxe || return 1
		sudo ln -sf $FIND_RESULT/std /usr/lib/haxe/std || return 1
		
		VERSION="`basename $FIND_RESULT`"
		printf "${BRIGHT_GREEN}haxe version set to ${BRIGHT_WHITE}${BOLD}${VERSION//haxe-/}${RESET}\n"
	else
		if [[ -n $FIND_RESULT ]]; then #not empty find result
			VERSIONS="`basename -a $FIND_RESULT`"
			printf "${BRIGHT_WHITE}${VERSIONS//haxe-/}\n"
		else
			printf "${BOLD}${RED}Version $1 not found.\n${BRIGHT_WHITE}Available versions are:${RESET}\n"
			FIND_ALL=`find /usr/lib/ -type d -maxdepth 1 -name "haxe-*"`
			VERSIONS="`basename -a $FIND_ALL`"
			printf "${BRIGHT_WHITE}${VERSIONS//haxe-/}\n"
		fi
	fi

	unset FIND_RESULT
	unset NUM_RESULTS
	unset VERSIONS
	unset VERSION
	unset FIND_ALL
}