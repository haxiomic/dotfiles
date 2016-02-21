Dotfiles
========

.bash_profile and terminal settings tested with OS X **10.7** to **10.11** (< 10.7 doesn't support 256 terminal colors without iTerm2).
Colors based on [ahmetsulek's Flat Terminal](https://github.com/ahmetsulek/flat-terminal)

Also includes iTerm2 scheme

![preview](preview.png)

###Installation
###### Regular
- Put the .bash_profile, .inputrc & .user_config into your home directory (`cd ~`)
- Open the .terminal or .itermcolors file and change profile preferences to set it as the default


###### Sym-linked
- First deal with your current .bash_profile and .inputrc file by backing up and removing
- Navigate to where you've cloned the repo and run:

```bash
ln -s $(pwd)/.bash_profile $HOME/.bash_profile
ln -s $(pwd)/.inputrc $HOME/.inputrc
```

- Open the .terminal or .itermcolors file and change profile preferences to set it as the default


--------
- If you're me, you should also sym link the *.user_config.bash* file
```bash
ln -sf $(pwd)/.user_config.bash $HOME/.user_config.bash
```
(If you're not me: it's designed for my personal setup and may cause issues if there's a conflict on your system)


###Aliases & Features
- **s** - *opens a file in sublime text*
- **si** *\<cmd\>* - *open the result of a command in sublime text, eg `si git diff`*
- **o** - *short for open. 'o' opens the current directory in finder* 
- **l** - *list files in long format*
- **la** - *list all files including dotfiles, in long format*
- **trash** *\<file\>* - *move file to trash*
- **serve** *starts a web server at the current directory*

###### navigation
- **z** *<search string>* - *jump to commonly used directories*
- **bk** - *go back a directory*
- **desktop** - *cd ~/Desktop*
- **..** 	- *cd ..*
- **...** 	- *cd ../..*
- **....** 	- *cd ../../..*
- **.....** - *cd ../../../..*

###### git
- **gs** - *git status*
- **ga** - *git add .*
- **gc** *\<message\>* - *git commit -m*
- **gca** *\<message\>* - *git commit -a -m*
- **gcap** *\<message\>* - *git commit -a -m \<message\> && git push*
- **gpush** - *git push*
- **gpull** - *git pull*
- **gdiff** - *git diff*
- **gsetup** *<repo-url>* - *initialises repo with a given url*
- **gbrowser** - *opens the current remote origin url in the browser*

###### other
- **highlight** *\<file\>* - *syntax highlighting in terminal, (requires [pygmentize](http://pygments.org/))*
- **show** / **hide** - *show/hide hidden files* 
- **sman** - *open man page with text edtior*
- **delete_extra_bash_scripts** - *clears auto-installed bash-scripts*
- **[TAB] Autocomplete is improved with single tab instead of two and case insensitivity**

###Auto-installed scripts

Additional scripts installed into ~/.bash_scripts/ on first run

- [z jump script](https://github.com/rupa/z) - 'Tracks your most used directories, based on frequency'
- [git-completion](https://github.com/git/git/tree/master/contrib/completion) - Autocomplete for git from Github's main repository
- [trash](https://github.com/morgant/tools-osx) - 'trash allows trashing of files instead of tempting fate with rm'

###Dependencies
- git

###Key bindings iTerm2 (manual entry)
text-editor style line navigation  

| Combo 	| Action         	| Send 	|
|-------	|----------------	|------	|
| ⌘←    	| "HEX CODE"     	| 0x01
| ⌘→    	| "HEX CODE"     	| 0x05
| ⌥←    	| "SEND ESC SEQ" 	| b
| ⌥→    	| "SEND ESC SEQ" 	| f