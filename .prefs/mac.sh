#!/bin/bash
set -euo pipefail

# Only install brew if not already installed.
if ! type "brew" > /dev/null; then
  echo "[Brew] installing"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update brew to get the latest juice.
echo "[Brew] update"
brew update

# Install any updates before so it won't conflicts with installs.
echo "[Brew] upgrade"
brew upgrade

# Java.
brew install openjdk
echo "Linking OpenJDK"
sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk

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

# Youtube Downloader.
brew install yt-dlp/taps/yt-dlp

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

# Workarounds for Pidcat.
# https://github.com/JakeWharton/pidcat/issues/180#issuecomment-1124019329
brew install pyenv
echo n | pyenv install 2.7.18 || true

# Pidcat.
brew install pidcat

# Change pidcat to use Python 2.7.18
echo "Workaround for installing pidcat properly requires sudo"
sudo sed -i '1d' "$(command -v pidcat)"
sudo sed -i "1i #\!$HOME/.pyenv/versions/2.7.18/bin/python -u" "$(command -v pidcat)"

# jq.
brew install jq

# Postgres.
brew install postgresql
brew services start postgresql

# Slack.
brew install --cask slack

# Thunderbird.
brew install --cask thunderbird

# VLC.
brew install vlc

# Sublime.
brew install --cask sublime-text

###
 # From this point downwards it's OS specific things.
###

# https://github.com/odlp/bluesnooze/pull/14
brew install --cask bluesnooze

# Fonts (Chinese for Feature Grahpic Generation).
noto_sans_sc_count=$(find /Library/Fonts/ -name "NotoSansSC*.otf" | wc -l | sed 's/^ *//g')

if [[ $noto_sans_sc_count -gt 0 ]]; then
  echo "Already downloaded and installed NotoSansSC."
else
  echo "Installing NotoSansSC."
  curl https://fonts.google.com/download?family=Noto%20Sans%20SC > "$HOME/Downloads/Noto-Sans-SC.zip"
  unzip "$HOME/Downloads/Noto-Sans-SC.zip" -d "$HOME/Downloads/Noto-Sans-SC/"
  cp "$HOME"/Downloads/Noto-Sans-SC/*.otf /Library/Fonts/
  rm -f "$HOME/Downloads/Noto-Sans-SC.zip"
  rm -rf "$HOME/Downloads/Noto-Sans-SC/"
fi

noto_sans_tc_count=$(find /Library/Fonts/ -name "NotoSansTC*.otf" | wc -l | sed 's/^ *//g')

if [[ $noto_sans_tc_count -gt 0 ]]; then
  echo "Already downloaded and installed NotoSansTC."
else
  echo "Installing NotoSansTC."
  curl https://fonts.google.com/download?family=Noto%20Sans%20TC > "$HOME/Downloads/Noto-Sans-TC.zip"
  unzip "$HOME/Downloads/Noto-Sans-TC.zip" -d "$HOME/Downloads/Noto-Sans-TC/"
  cp "$HOME"/Downloads/Noto-Sans-TC/*.otf /Library/Fonts/
  rm -f "$HOME/Downloads/Noto-Sans-TC.zip"
  rm -rf "$HOME/Downloads/Noto-Sans-TC/"
fi

# cairosvg ic_keyboard_arrow_left_48px.svg -o ic_keyboard_arrow_left_48px.pdf
brew install python3 cairo pango gdk-pixbuf libffi
pip3 install cairosvg

# Sublime.
mkdir -p ~/bin/
ln -sfn "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl

# Heroku.
brew tap heroku/brew && brew install heroku

# node.
brew install node

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
# This only works when XCode is installed and since it takes forever to download, we'll default to true!
brew install swiftlint || true

# Cocoapods.
# This only works when XCode is installed and since it takes forever to download, we'll default to true!
brew install cocoapods || true

# AWS.
brew install awscli
brew install docker-credential-helper-ecr
brew install --cask session-manager-plugin

# Duti.
# duti -x sh
# To get the application id use: `osascript -e 'id of app "VLC"'`
brew install duti
duti -s com.sublimetext.4 .css all
duti -s com.sublimetext.4 .gradle all
duti -s com.sublimetext.4 .groovy all
duti -s com.sublimetext.4 .java all
duti -s com.sublimetext.4 .json all
duti -s com.sublimetext.4 .kt all
duti -s com.sublimetext.4 .kts all
duti -s com.sublimetext.4 .log all
duti -s com.sublimetext.4 .md all
duti -s com.sublimetext.4 .properties all
duti -s com.sublimetext.4 .sh all
duti -s com.sublimetext.4 .sq all
duti -s com.sublimetext.4 .sqm all
duti -s com.sublimetext.4 .svg all
duti -s com.sublimetext.4 .swift all
duti -s com.sublimetext.4 .toml all
duti -s com.sublimetext.4 .txt all
duti -s com.sublimetext.4 .xml all
duti -s org.mozilla.thunderbird .eml all
duti -s org.videolan.vlc .mp3 all
duti -s org.videolan.vlc .mp4 all
duti -s org.videolan.vlc .webm all

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

# Use proper function keys. Needs a restart.
defaults write "Apple Global Domain" com.apple.keyboard.fnState -int 1

# Clock with seconds. Needs a restart.
defaults write "com.apple.menuextra.clock" ShowSeconds -int 1

# Show dot files in finder.
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

# Restart the service in order to propagate changes.
killall SystemUIServer

source unix.sh
