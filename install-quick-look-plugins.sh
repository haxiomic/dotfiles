if ! [ -x "$(command -v brew)" ]; then
	echo "macOS homebrew is required"
	exit 1
fi

brew cask install qlcolorcode # syntax highlighting
brew cask install qlstephen # plain text files
brew cask install qlmarkdown # markdown
brew cask install gltfquicklook # gltf
brew cask install qlprettypatch # .patch files

# more
# quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize suspicious-package