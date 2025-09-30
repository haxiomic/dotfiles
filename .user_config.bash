########## User Specific Config ########## 
EDITOR_OF_CHOICE="Sublime Text*.app"
PROJECTS="$HOME/Projects"

alias p="cd $PROJECTS"
alias d="cd ~/Downloads"
alias claude-fun="claude --dangerously-skip-permissions"
alias cf="claude-fun"

# haxe
export HAXE_HOME=/usr/local/lib/haxe
export NEKO_HOME=/usr/local/lib/neko

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# firefox development
export MOZBUILD_STATE_PATH=~/Projects/firefox/mozbuild

# python
# pip --user packages
# export PATH="~/Library/Python/3.6/bin:$PATH" 
# brew python replacement on macOS
export PATH="/usr/local/opt/python@2/bin:$PATH"

# ruby
export PATH="/usr/local/opt/ruby@2.3/bin:$PATH"

# ocaml & opam
test -r /Users/geo/.opam/opam-init/init.sh && . /Users/geo/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# java
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-11.0.1.jdk/Contents/Home"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/geo/SDKs/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/geo/SDKs/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/geo/SDKs/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/geo/SDKs/google-cloud-sdk/completion.zsh.inc'; fi

#android
# export ANDROID_NDK_ROOT=~/SDKs/android/android-ndk-r20

# export ANDROID_SDK=~/Library/Android/sdk
# export ANDROID_HOME=$ANDROID_SDK
# export ANT_HOME=~/Library/Android/apache-ant
# export OCULUS_SDK_PATH=~/Library/Oculus/ovr_sdk_mobile_1.0.3

#exposes to Android Studio
# launchctl setenv ANDROID_SDK $ANDROID_SDK 
# launchctl setenv ANDROID_SDK $ANDROID_SDK
# launchctl setenv ANDROID_HOME $ANDROID_HOME
# launchctl setenv OCULUS_SDK_PATH $OCULUS_SDK_PATH

# export JAVA_HOME=/Library/Java/Home
# PATH=$PATH:$ANDROID_SDK/tools
# PATH=$PATH:$ANDROID_SDK/platform-tools
# PATH=$PATH:$ANDROID_SDK/build-tools/23.0.2
# PATH=$PATH:$ANDROID_NDK
# PATH=$PATH:$ANT_HOME/bin

# node.js: change the npm global modules directory to fix access issues
# 
# export NPM_CONFIG_PREFIX=~/.npm-global
# PATH=$PATH:$NPM_CONFIG_PREFIX/bin
# if [ ! -d $NPM_CONFIG_PREFIX ]; then
#     mkdir -p $NPM_CONFIG_PREFIX
#     sudo chown -R $USER ~/.npm
# fi

#C/C++ build environment
# export CXX="`which clang++`"
# export CC="`which clang`"
# export CPP="`which clang` -E"
# export LINK="`which clang++`"
# export CXX_host="`which clang++`"
# export CC_host="`which clang`"
# export CPP_host="`which clang` -E"
# export LINK_host="`which clang++`"
# export GYP_DEFINES="clang=1"

#chromium build tools (add to start of path), http://www.chromium.org/developers/how-tos/install-depot-tools
# PATH=/usr/local/lib/depot_tools:$PATH

alias hxr="haxelib run"
alias v=_open_in_vscode

# 
function _open_in_vscode(){
	if [[ -z "$1" ]] ; then
		code .
		return
	fi
	code "$1"
}

# Hello Project
function hello-web(){
    if [ -z "$@" ]; then
        echo "Project named required"
        return
    else
        PROJ_NAME="$@"
    fi

    {
        mkdir "$PROJ_NAME" &&
        cd "$PROJ_NAME" &&
        mkdir css images js lib &&
        touch css/app.css js/app.js &&
        echo -e '<!DOCTYPE html>\n<html>\n\t<head>\n\t\t<title>'$PROJ_NAME'</title>\n\t\t<meta charset="utf-8">\n\t\t<link rel="stylesheet" type="text/css" href="css/app.css">\n\t</head>\n\t<body>\n\t\t<h1>Hello '$PROJ_NAME'</h1>\n\t\t<script type="text/javascript" src="js/app.js"></script>\n\t</body>\n</html>' > index.html &&

        cd ../ &&

        echo 'Created project "'$PROJ_NAME'"'
    }

    unset PROJ_NAME
}

function hello-haxe(){
    if [ -z "$@" ]; then
        echo "Project named required"
        return
    else
        PROJ_NAME="$@"
    fi

    {
        mkdir "$PROJ_NAME" &&
        cd "$PROJ_NAME" &&
        mkdir src &&

        echo -e '-main Main\n-cp src\n--interp' > build.hxml &&
        echo -e 'class Main {\r\n\r\n\tstatic function main(){\r\n\t\ttrace("Hello '$PROJ_NAME'");\r\n\t}\r\n\r\n}' > src/Main.hx &&

        cd ../ &&
        
        echo 'Created project "'$PROJ_NAME'"'
    }

    unset PROJ_NAME
}

#folders should be named like: haxe-3.1.3, and the regular haxe folder should be removed
alias setHaxeVersion=_set_haxe_version
function _set_haxe_version(){
    HAXE_PARENT="$(dirname "$HAXE_HOME")"

    FIND_RESULT="`find $HAXE_PARENT -maxdepth 1 -name "haxe-*$1"`"
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

# run `haxemake watch` to rebuild when files change
function haxemake(){
    make --file="$EXTRA_SCRIPTS_DIR/haxemake.mk" $@
}

if $INSTALL_EXTRA_SCRIPTS; then

    SCRIPT_NAME='haxemake.mk'
    SCRIPT_URL='https://gist.githubusercontent.com/haxiomic/0d316a34b6ee7adc5f27d4aaeb1ae692/raw/b3e42e4e605f79474d12d8adf56eac914e600161/Haxe%2520Makefile'
    SCRIPT_SEE='https://gist.github.com/haxiomic/0d316a34b6ee7adc5f27d4aaeb1ae692'
    install_extra_bash_script "$SCRIPT_NAME" "$SCRIPT_URL" "$SCRIPT_SEE"

    unset SCRIPT_NAME
    unset SCRIPT_URL
    unset SCRIPT_SEE

fi