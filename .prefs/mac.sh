#!/bin/bash
set -euo pipefail

# Only install brew if not already installed.
if ! type "brew" > /dev/null; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update brew to get the latest juice.
brew update

# Install any updates before so it won't conflicts with installs.
brew upgrade

# OpenJDK.
brew cask install adoptopenjdk

# Gradle.
brew install gradle

# Git.
brew install git
brew install git-standup

# Tree.
brew install tree

# Htop.
brew install htop

# Hub for GitHub.
brew install hub

# Go-Jira.
brew install go-jira

# Phraseapp.
brew tap phrase/brewed
brew install phraseapp

# Ack.
brew install ack

# Bat
brew install bat

# Youtube-dl.
brew install youtube-dl

# Images.
brew install imagemagick

# Count Lines of Code.
brew install cloc

# Z.
brew install z

# Speedtest.
brew install speedtest-cli

# Shellcheck.
brew install shellcheck

# Diff-so-fancy.
brew install diff-so-fancy

# Pidcat.
brew install pidcat

# jq.
brew install jq

# Postgres.
brew install postgresql
brew services start postgresql

###
 # From this point downwards it's OS specific things.
###

# cairosvg ic_keyboard_arrow_left_48px.svg -o ic_keyboard_arrow_left_48px.pdf
brew install python3 cairo pango gdk-pixbuf libffi
pip3 install cairosvg

# Sublime.
ln -sfn "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl

# Cocoapods.
sudo gem install cocoapods

# Ffmpeg.
brew install ffmpeg

# Less (want to have the same variant as with Ubuntu).
brew install less

# Sed (want to have the same variant as with Ubuntu).
brew install gnu-sed

# Poppler which brings pdfseparate (pdfseparate sample.pdf sample-%d.pdf and others).
brew install poppler

# Dot for magic images.
brew install graphviz

# Cleaning up.
brew cleanup

# Disable shadow when taking a screenshot.
defaults write com.apple.screencapture disable-shadow -bool TRUE

# Disable sound effects. For example when taking a screenshot.
defaults write "Apple Global Domain" com.apple.sound.uiaudio.enabled -int 0

# Faster keyboard execution.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Restart the service in order to propagate changes.
killall SystemUIServer

source unix.sh
