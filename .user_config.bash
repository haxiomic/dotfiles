########## User Specific Config ########## 
EDITOR_OF_CHOICE="Sublime Text*.app"
PROJECTS="$HOME/Projects"

alias p="cd $PROJECTS"
alias d="cd ~/Desktop"

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
alias serve=_start_server_on_free_port
alias server=serve

function _start_server_on_free_port(){
	#start a server with simple-autoreload-server or a python simple http server

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
			[ -d "./scss" ] && sass --watch scss:css
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
		if [ -f "index.html" ]; then
			open http://127.0.0.1:$PORT/index.html
		else
			open http://127.0.0.1:$PORT
		fi

		echo -e "\n${BOLD}${BRIGHT_WHITE} - Press enter to terminate - ${RESET}" &
	} &

	#start server
	if type autoreload-server >/dev/null 2>&1; then #https://github.com/cytb/simple-autoreload-server
		autoreload-server -f --port $PORT &
	else
		#use a basic python server
		PYTHON_EDITION=$(python -c 'import sys;import re;print int(re.compile("\d+").findall(sys.version)[0]);')
		if (( PYTHON_EDITION < 3 )); then
			#python 2
			python -m SimpleHTTPServer $PORT &
		else
			#python 3
			python -m http.server &
		fi
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

#folders should be named like: haxe-3.1.3, and the regular haxe folder should be removed
alias setHaxeVersion=_set_haxe_version
function _set_haxe_version(){
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