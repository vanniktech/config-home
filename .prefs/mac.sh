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
brew install --cask zulu

# Gradle.
brew install --ignore-dependencies gradle

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

# Ack.
brew install ack

# Bat
brew install bat

# Youtube Downloader.
brew install yt-dlp

# Images.
brew install imagemagick

# Count Lines of Code.
brew install cloc

# Z.
brew install z

# ruby.
brew install ruby

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
brew install --cask vlc

# Sublime.
brew install --cask sublime-text

###
 # From this point downwards it's OS specific things.
###

# Change mp3 meta information. https://apple.stackexchange.com/a/236355
# Change artist: id3v2 -a "Prince" 01\ Wow.mp3
# Change title: id3v2 -t "Wow" 01\ Wow.mp3
brew install id3v2

# Images & MP3 files.
# eyeD3 --add-image="FRONT_COVER.jpg":FRONT_COVER "music.mp3"
# eyeD3 --write-images=. "music.mp3"
brew install eye-d3

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

noto_sans_jp_count=$(find /Library/Fonts/ -name "NotoSansJP*.otf" | wc -l | sed 's/^ *//g')

if [[ $noto_sans_jp_count -gt 0 ]]; then
  echo "Already downloaded and installed NotoSansJP."
else
  echo "Installing NotoSansJP."
  curl https://fonts.google.com/download?family=Noto%20Sans%20JP > "$HOME/Downloads/Noto-Sans-JP.zip"
  unzip "$HOME/Downloads/Noto-Sans-JP.zip" -d "$HOME/Downloads/Noto-Sans-JP/"
  cp "$HOME"/Downloads/Noto-Sans-JP/*.otf /Library/Fonts/
  rm -f "$HOME/Downloads/Noto-Sans-JP.zip"
  rm -rf "$HOME/Downloads/Noto-Sans-JP/"
fi

noto_sans_kr_count=$(find /Library/Fonts/ -name "NotoSansKR*.otf" | wc -l | sed 's/^ *//g')

if [[ $noto_sans_kr_count -gt 0 ]]; then
  echo "Already downloaded and installed NotoSansKR."
else
  echo "Installing NotoSansKR."
  curl https://fonts.google.com/download?family=Noto%20Sans%20KR > "$HOME/Downloads/Noto-Sans-KR.zip"
  unzip "$HOME/Downloads/Noto-Sans-KR.zip" -d "$HOME/Downloads/Noto-Sans-KR/"
  cp "$HOME"/Downloads/Noto-Sans-KR/*.otf /Library/Fonts/
  rm -f "$HOME/Downloads/Noto-Sans-KR.zip"
  rm -rf "$HOME/Downloads/Noto-Sans-KR/"
fi

# cairosvg ic_keyboard_arrow_left_48px.svg -o ic_keyboard_arrow_left_48px.pdf
brew install python3 cairo pango gdk-pixbuf libffi
pip3 install cairosvg

# Sublime.
mkdir -p ~/bin/
ln -sfn "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ~/bin/subl

# node.
brew install node

# gnupg.
brew install gnupg

# Swiftgen
brew install swiftgen

# Required for building.
brew install coreutils

# Ffmpeg.
brew install ffmpeg

# Less (want to have the same variant as with Ubuntu).
brew install less

# ncdu $HOME
brew install ncdu

# Sed (want to have the same variant as with Ubuntu).
# https://www.pement.org/sed/sed1line.txt
brew install gnu-sed

# Poppler which brings pdfseparate (pdfseparate sample.pdf sample-%d.pdf and others).
brew install poppler

# aspell. Typos checking.
brew install aspell

# Dot for magic images.
brew install graphviz

# Flux.
brew install --cask flux

# Swiftlint.
# This only works when XCode is installed and since it takes forever to download, we'll default to true!
brew install swiftlint || true

# Cocoapods.
# This only works when XCode is installed and since it takes forever to download, we'll default to true!
brew install cocoapods || true

# Git-cliff.
brew install git-cliff

# AWS.
brew install awscli
brew install docker-credential-helper-ecr
brew install --cask session-manager-plugin

# Duti.
# duti -x sh
# To get the application id use: `osascript -e 'id of app "VLC"'`
brew install duti
duti -s com.sublimetext.4 .cfg all
duti -s com.sublimetext.4 .conf all
duti -s com.sublimetext.4 .css all
duti -s com.sublimetext.4 .csv all
duti -s com.sublimetext.4 .gpx all
duti -s com.sublimetext.4 .gradle all
duti -s com.sublimetext.4 .groovy all
duti -s com.sublimetext.4 .ini all
duti -s com.sublimetext.4 .java all
duti -s com.sublimetext.4 .json all
duti -s com.sublimetext.4 .kt all
duti -s com.sublimetext.4 .kts all
duti -s com.sublimetext.4 .lock all
duti -s com.sublimetext.4 .log all
duti -s com.sublimetext.4 .md all
duti -s com.sublimetext.4 .ncx all
duti -s com.sublimetext.4 .opf all
duti -s com.sublimetext.4 .pbxproj all
duti -s com.sublimetext.4 .php all
duti -s com.sublimetext.4 .plist all
duti -s com.sublimetext.4 .pom all
duti -s com.sublimetext.4 .pro all
duti -s com.sublimetext.4 .properties all
duti -s com.sublimetext.4 .rb all
duti -s com.sublimetext.4 .service all
duti -s com.sublimetext.4 .sh all
duti -s com.sublimetext.4 .sq all
duti -s com.sublimetext.4 .sqm all
duti -s com.sublimetext.4 .strings all
duti -s com.sublimetext.4 .svg all
duti -s com.sublimetext.4 .swift all
duti -s com.sublimetext.4 .toml all
duti -s com.sublimetext.4 .txt all
duti -s com.sublimetext.4 .vtt all
duti -s com.sublimetext.4 .xcprivacy all
duti -s com.sublimetext.4 .xib all
duti -s com.sublimetext.4 .xml all
duti -s com.sublimetext.4 .yml all
duti -s org.mozilla.thunderbird .eml all
duti -s org.videolan.vlc .m4a all
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

# Show all extensions in Finder.
defaults write "Apple Global Domain" AppleShowAllExtensions -int 1

# Clear Trash after 30 days.
defaults write com.apple.Finder FXRemoveOldTrashItems -int 1

# Show dot files in finder.
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder

# XCode compilation time.
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool YES

# Restart the service in order to propagate changes.
killall SystemUIServer

source unix.sh
