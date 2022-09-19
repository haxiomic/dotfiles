Dotfiles
========

.zsh and terminal settings tested with OS X **10.7** to **12.6** (< 10.7 doesn't support 256 terminal colors without iTerm2).
Colors based on [ahmetsulek's Flat Terminal](https://github.com/ahmetsulek/flat-terminal)

Also includes iTerm2 scheme

![preview](preview.png)

### Installation
###### Regular
- Put the .zsh and .inputrc into your home directory (`cd ~`)
- Open the .terminal or .itermcolors file and change profile preferences to set it as the default


###### Sym-linked
- First deal with your current .zsh and .inputrc file by backing up and removing
- Navigate to where you've cloned the repo and run:

```bash
ln -s $(pwd)/.zshrc $HOME/.zshrc
ln -s $(pwd)/.inputrc $HOME/.inputrc
```

- Open the .terminal file and change profile preferences to set it as the default


### Aliases & Features
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
- **gopen** - *opens current repository in a browser* [more info](https://github.com/paulirish/git-open/blob/master/git-open)

###### other
- **sman** - *open man page with text edtior*
- **[TAB] Autocomplete is improved with single tab instead of two and case insensitivity**

### Auto-installed scripts

Additional scripts installed into ~/.bash_scripts/ on first run

- [z jump script](https://github.com/rupa/z) - 'Tracks your most used directories, based on frequency'
- [git-completion](https://github.com/git/git/tree/master/contrib/completion) - Autocomplete for git from Github's main repository
- [trash](https://github.com/morgant/tools-osx) - 'trash allows trashing of files instead of tempting fate with rm'
- [git-open](https://github.com/paulirish/git-open) - 'Type git-open to open the GitHub page or website for a repository in your browser'

### Dependencies
- git
- node.js/npm

### Sublime style keybindings for Xcode
Sym link or copy [Sublime.idekeybindings](Sublime.idekeybindings) into `~/Library/Developer/Xcode/UserData/KeyBindings/`

```bash
ln -s $(pwd)/Sublime.idekeybindings ~/Library/Developer/Xcode/UserData/KeyBindings/Sublime.idekeybindings
```

### Key bindings iTerm2 (manual entry)
text-editor style line navigation  

| Combo 	| Action         	| Send 	|
|-------	|----------------	|------	|
| ⌘←    	| "HEX CODE"     	| 0x01
| ⌘→    	| "HEX CODE"     	| 0x05
| ⌥←    	| "SEND ESC SEQ" 	| b
| ⌥→    	| "SEND ESC SEQ" 	| f