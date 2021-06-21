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
brew install --cask adoptopenjdk

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

# Heroku.
brew tap heroku/brew && brew install heroku

# node.
brew install node

# Cocoapods.
sudo gem install cocoapods

# Swiftgen
brew install swiftgen

# Required for building.
brew install coreutils

# Ffmpeg.
brew install ffmpeg

# Less (want to have the same variant as with Ubuntu).
brew install less

# Sed (want to have the same variant as with Ubuntu).
brew install gnu-sed

# Poppler which brings pdfseparate (pdfseparate sample.pdf sample-%d.pdf and others).
brew install poppler

# aspell. Typos checking.
brew install aspell

# Dot for magic images.
brew install graphviz

# Swiftlint.
brew install swiftlint

# AWS.
brew install awscli
brew install docker-credential-helper-ecr
brew install --cask session-manager-plugin

# Docker.
brew install virtualbox
brew install docker
brew install docker-machine

# DVDs.
brew install libdvdcss handbrake

# Set up Docker.
docker-machine create --driver virtualbox default
docker-machine restart
eval "$(docker-machine env default)"
docker-machine restart

# Cleaning up.
brew cleanup

# Disable shadow when taking a screenshot.
defaults write com.apple.screencapture disable-shadow -bool TRUE

# Disable sound effects. For example when taking a screenshot.
defaults write "Apple Global Domain" com.apple.sound.uiaudio.enabled -int 0
defaults write NSGlobalDomain _HIHideMenuBar -bool true

# Faster keyboard execution.
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

# Disable Smart Quoutes & Dashes.
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -int 0
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -int 0

# Disable full stop with double-space.
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -int 0

# Dock tweaks like auto hide.
defaults write com.apple.dock autohide -int 1
killall Dock

# Show dot files in finder.
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

# Restart the service in order to propagate changes.
killall SystemUIServer

source unix.sh
