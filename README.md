Dotfiles
========

.bash_profile and terminal settings

###Auto-installed scripts

several scripts into ~/bash_scripts

- [git-completion](https://github.com/git/git/tree/master/contrib/completion)
- [z](https://github.com/rupa/z)

###Installation
- Put the .bash_profile into your home ~ directory
- Open the .terminal file and change terminal preferences to set to default

###### Alternatively use a sym link
Navigate to where you've chosen to placed the files or clone the repo and then run:

```bash
ln -s $(pwd)/.bash_profile $HOME/.bash_profile
open ./Haxiomic.terminal
```
![preview](preview.png)
	 