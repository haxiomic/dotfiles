########## User Specific Config ########## 
PROJECTS="$HOME/Projects"

EDITOR_OF_CHOICE="Sublime Text*.app"

FLATCOLORS=false	#this sets the terminal's PS1 & 2 colors based on the flat 256 color values given in this file. To let your terminal decide the colors, set to false.
					#use true for non-mac terminals

INSTALL_EXTRA_SCRIPTS=true #enables auto installing and running of extra scripts

LIME_TOOL="haxelib run aether"
alias lmac="$LIME_TOOL test mac"
alias lflash="$LIME_TOOL test flash"
alias lhtml="$LIME_TOOL test html5"
alias lios="$LIME_TOOL test ios"

FLOW_TOOL="haxelib run flow"
alias flow=$FLOW_TOOL
alias fmac="$FLOW_TOOL run mac"
alias fflash="$FLOW_TOOL run flash"
alias fweb="$FLOW_TOOL run web --timeout 0"
alias fios="$FLOW_TOOL run ios"

#haxe
export HAXE_HOME=/usr/lib/haxe
#android
export ANDROID_NDK=~/Library/Android/ndk
export ANDROID_HOME=~/Library/Android/sdk
export ANT_HOME=~/Library/Android/apache-ant
export JAVA_HOME=/Library/Java/Home

PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/build-tools/22.0.1
PATH=$PATH:$ANDROID_NDK
PATH=$PATH:$ANT_HOME/bin
PATH=$PATH:$JAVA_HOME/bin

#quick webserver
alias serve="autoreload-server -f --port 8080" #https://github.com/cytb/simple-autoreload-server

#folders should be named like: haxe-3.1.3, and the regular haxe folder should be removed
function setHaxeVersion(){
	FIND_RESULT="`find /usr/lib/ -type d -maxdepth 1 -name "haxe-*$1"`"
	NUM_RESULTS=`echo "$FIND_RESULT" | wc -l`

	if [[ $NUM_RESULTS -eq 1 ]] && [[ -n $FIND_RESULT ]] ; then

		if [[ ! -d /usr/lib/haxe/lib ]] ; then #make haxe dir & lib if they don't exist
			sudo mkdir -p /usr/lib/haxe/lib
		fi

		sudo ln -sf $FIND_RESULT/haxe /usr/lib/haxe || return 1
		sudo ln -sf $FIND_RESULT/haxelib /usr/lib/haxe || return 1
		sudo ln -sf $FIND_RESULT/std /usr/lib/haxe || return 1
		
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