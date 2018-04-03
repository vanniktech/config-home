#!/bin/bash
set -euo pipefail

# Install brew.
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Brew some craft packages.
brew install z ffmpeg ack diff-so-fancy git hub gnu-sed imagemick gradle less pidcat thefuck youtube-dl

# Phraseapp.
brew tap phrase/brewed
brew install phraseapp

# dot for magic images.
brew install graphviz

# Disable shadow while screenshotting.
defaults write com.apple.screencapture disable-shadow -bool TRUE
killall SystemUIServer
