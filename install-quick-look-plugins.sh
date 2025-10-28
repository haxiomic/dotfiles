if ! [ -x "$(command -v brew)" ]; then
	echo "macOS homebrew is required"
	exit 1
fi

brew install qlcolorcode --cask  # syntax highlighting
brew install qlstephen --cask  # plain text files
brew install qlmarkdown --cask  # markdown
brew install gltfquicklook --cask  # gltf
brew install qlprettypatch --cask  # .patch files

# more
# quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize suspicious-package