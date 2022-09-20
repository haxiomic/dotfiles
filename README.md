Dotfiles
========

Tested with OS X **10.7** to **12.6**. Colors based on [ahmetsulek's Flat Terminal](https://github.com/ahmetsulek/flat-terminal)

![https://user-images.githubusercontent.com/3742992/191121416-f75e515b-da46-4853-ba56-e3c14bbbb789.png](https://user-images.githubusercontent.com/3742992/191121416-f75e515b-da46-4853-ba56-e3c14bbbb789.png)

### Installation

- First deal with your current .zsh file by backing up and removing if you have one
- Navigate to where you've cloned the repo and run:

```bash
ln -s $(pwd)/.zshrc $HOME/.zshrc
```

- Open the .terminal file and change profile preferences to set it as the default

### Aliases & Features
- **s** - *opens a file in sublime text*
- **si** *\<cmd\>* - *open the result of a command in text editor, eg `si git diff`*
- **sman** *\<cmd\>* - *open the man page of a command in text editor, eg `sman top`*
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
Symlink or copy [Sublime.idekeybindings](Sublime.idekeybindings) into `~/Library/Developer/Xcode/UserData/KeyBindings/`

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