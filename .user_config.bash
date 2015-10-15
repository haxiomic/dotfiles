########## User Specific Config ########## 
EDITOR_OF_CHOICE="Sublime Text*.app"
PROJECTS="$HOME/Projects"

alias p="cd $PROJECTS"
alias d="cd ~/Desktop"

alias run="./run.sh"
alias build="./build.sh"

LIME_TOOL="haxelib run lime"
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
export HAXE_HOME=/usr/local/lib/haxe
#android
export ANDROID_NDK=~/Library/Android/ndk
export ANDROID_HOME=~/Library/Android/sdk
export ANT_HOME=~/Library/Android/apache-ant
export JAVA_HOME=/Library/Java/Home
#npm
#changes the npm global modules directory
export NPM_CONFIG_PREFIX=~/.npm-global

PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/build-tools/22.0.1
PATH=$PATH:$ANDROID_NDK
PATH=$PATH:$ANT_HOME/bin
PATH=$PATH:$JAVA_HOME/bin
PATH=$PATH:$NPM_CONFIG_PREFIX/bin

#fix npm access issues
if [ ! -d $NPM_CONFIG_PREFIX ]; then
    mkdir -p $NPM_CONFIG_PREFIX
    sudo chown -R $USER ~/.npm
fi

# Hello Project
function hello-web(){
    if [ -z "$@" ]; then
        PROJ_NAME="Hello Web"
    else
        PROJ_NAME="$@"
    fi

    {
        mkdir "$PROJ_NAME" &&
        cd "$PROJ_NAME" &&
        mkdir css images js lib &&
        touch css/app.css js/app.js &&
        echo -e '<!DOCTYPE html>\n<html>\n\t<head>\n\t\t<title>'$PROJ_NAME'</title>\n\t\t<link rel="stylesheet" type="text/css" href="css/app.css">\n\t</head>\n\t<body>\n\t\t<h1>'$PROJ_NAME'</h1>\n\t\t<script type="text/javascript" src="js/app.js"></script>\n\t</body>\n</html>' > index.html &&

        # cd ../ &&

        echo 'Created project "'$PROJ_NAME'"'
    }

    unset PROJ_NAME
}

function hello-haxe(){
    if [ -z "$@" ]; then
        PROJ_NAME="Hello Haxe"
    else
        PROJ_NAME="$@"
    fi

    {
        mkdir "$PROJ_NAME" &&
        cd "$PROJ_NAME" &&
        mkdir src &&

        echo -e '-main Main\n-cp src\n-neko bin/main.n' > build.hxml &&
        echo -e 'haxe build.hxml &&\nneko bin/main.n' > run.sh &&
        echo -e 'class Main{\r\n\r\n\tstatic function main(){\r\n\t\ttrace("'$PROJ_NAME'");\r\n\t}\r\n\r\n}' > src/Main.hx &&

        chmod +x run.sh &&

        # cd ../ &&
        
        echo 'Created project "'$PROJ_NAME'"'
    }

    unset PROJ_NAME
}

#folders should be named like: haxe-3.1.3, and the regular haxe folder should be removed
alias setHaxeVersion=_set_haxe_version
function _set_haxe_version(){
    HAXE_PARENT="$(dirname "$HAXE_HOME")"

    FIND_RESULT="`find $HAXE_PARENT -type d -maxdepth 1 -name "haxe-*$1"`"
    NUM_RESULTS=`echo "$FIND_RESULT" | wc -l`

    if [[ $NUM_RESULTS -eq 1 ]] && [[ -n $FIND_RESULT ]] ; then

        if [[ ! -d $HAXE_HOME/lib ]] ; then #make haxe dir & lib if they don't exist
            sudo mkdir -p $HAXE_HOME/lib
        fi

        sudo ln -sf $FIND_RESULT/haxe $HAXE_HOME || return 1
        sudo ln -sf $FIND_RESULT/haxelib $HAXE_HOME || return 1
        sudo ln -sf $FIND_RESULT/std $HAXE_HOME || return 1
        
        VERSION="`basename $FIND_RESULT`"
        printf "${BRIGHT_GREEN}haxe version set to ${BRIGHT_WHITE}${BOLD}${VERSION//haxe-/}${RESET}\n"
    else
        if [[ -n $FIND_RESULT ]]; then #not empty find result
            VERSIONS="`basename -a $FIND_RESULT`"
            printf "${BRIGHT_WHITE}${VERSIONS//haxe-/}\n"
        else
            printf "${BOLD}${RED}Version $1 not found.\n${BRIGHT_WHITE}Available versions are:${RESET}\n"
            FIND_ALL=`find $HAXE_PARENT -type d -maxdepth 1 -name "haxe-*"`
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