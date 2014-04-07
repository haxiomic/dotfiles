########## User Specific Config ########## 
PROJECTS="$HOME/Projects"

EDITOR_OF_CHOICE="Sublime Text*.app"

FLATCOLORS=false	#this sets the terminal's PS1 & 2 colors based on the flat 256 color values given in this file. To let your terminal decide the colors, set to false.
					#use true for non-mac terminals

ENABLE_EXTRA_SCRIPTS=true #enables auto installing and running of extra scripts

alias haxedir="cd /usr/lib/haxe"
alias lmac="lime test mac"
alias lflash="lime test flash"
alias lhtml="lime test html5"
alias lios="lime test ios"

function setHaxeNew(){
	if [ ! -d /usr/lib/haxe ] ; then
		echo "${RED}No haxe!${RESET}"
		return
	fi

	#check there's a haxe.old to set to
	if [ ! -d /usr/lib/haxe.new ] ; then
		echo "${YELLOW}Can't find /usr/lib/haxe.new${RESET}"
		return
	fi

	#check there isn't already a haxe new to move the current haxe to
	if [ -d /usr/lib/haxe.old ] ; then
		echo "${YELLOW}Can't rename current haxe to haxe.old because haxe.old already exists!${RESET}"
	fi

	#rename current haxe to haxe.old
	sudo mv /usr/lib/haxe /usr/lib/haxe.old
	#rename old haxe.old to haxe to set as current
	sudo mv /usr/lib/haxe.new /usr/lib/haxe
}

function setHaxeOld(){
	if [ ! -d /usr/lib/haxe ] ; then
		echo "${RED}No haxe!${RESET}"
		return
	fi

	#check there's a haxe.old to set to
	if [ ! -d /usr/lib/haxe.old ] ; then
		echo "${YELLOW}Can't find /usr/lib/haxe.old${RESET}"
		return
	fi

	#check there isn't already a haxe new to move the current haxe to
	if [ -d /usr/lib/haxe.new ] ; then
		echo "${YELLOW}Can't rename current haxe to haxe.new because haxe.new already exists!${RESET}"
	fi

	#rename current haxe to haxe.new
	sudo mv /usr/lib/haxe /usr/lib/haxe.new
	#rename old haxe.old to haxe to set as current
	sudo mv /usr/lib/haxe.old /usr/lib/haxe
}