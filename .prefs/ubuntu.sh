#!/bin/bash
set -euo pipefail

# Gradle.
sudo add-apt-repository ppa:cwchien/gradle
sudo apt-get update
sudo apt upgrade gradle

# Git.
sudo apt-get install git

# Tree.
sudo apt-get install tree

# htop.
sudo apt-get install htop

# Hub.
sudo add-apt-repository ppa:cpick/hub
sudo apt-get update
sudo apt-get install hub

# Go-Jira
wget -q -O jira https://github.com/Netflix-Skunkworks/go-jira/releases/download/v1.0.20/jira-linux-386 && chmod +x jira && sudo mv jira /usr/local/bin/

# Phraseapp.
wget -q -O phraseapp https://github.com/phrase/phraseapp-client/releases/download/1.7.4/phraseapp_linux_amd64 && chmod +x phraseapp && sudo mv phraseapp /usr/local/bin/

# Ack.
sudo apt-get install ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# bat. https://github.com/sharkdp/bat
wget -q -O bat.deb https://github.com/sharkdp/bat/releases/download/v0.6.0/bat_0.6.0_amd64.deb && sudo dpkg -i bat.deb && rm bat.deb

# Git standup.
curl -L https://raw.githubusercontent.com/kamranahmedse/git-standup/master/installer.sh | sudo sh

# pcregrep for grepping multilines.
sudo apt-get install pcregrep

# Remove crap.
sudo apt-get purge gedit rhythmbox unity-lens-shopping brasero brasero-common unity-lens-video unity-lens-music totem-gstreamer totem-common brasero deja-dup gnome-orca
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"

# Java.
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-8-jdk

# Music.
sudo apt-get install vlc

# Youtube dl.
sudo wget -q https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod a+rx /usr/local/bin/youtube-dl
sudo ln /usr/local/bin/youtube-dl /usr/bin/youtube-dl
sudo youtube-dl -U

# The fuck.
sudo pip3 install thefuck

# Filezilla.
sudo apt-get install filezilla

# Images.
sudo apt-get install imagemagick

# xclip (Copy paste).
sudo apt-get install xclip

# Count Lines of Code.
sudo apt-get install cloc

# Sublime 3.
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Clone Sublime settings.
sudo rm -rf ~/.config/sublime-text-3/
git clone git@github.com:vanniktech/config-sublime3.git ~/.config/sublime-text-3

# z.
sudo curl https://raw.githubusercontent.com/rupa/z/master/z.sh -o /etc/profile.d/z.sh

# Preload (Daemon that monitors the applications you use on your computer. Learns what you use and put things in memory.)
sudo apt-get install preload

# MP3 Handler for sox.
sudo apt-get install libsox-fmt-mp3

# Speedtest.
sudo apt-get install speedtest-cli

# Shellcheck. https://github.com/koalaman/shellcheck
sudo apt-get install shellcheck

# Diff-so-fancy.
wget -q -O diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy && chmod +x diff-so-fancy && sudo mv diff-so-fancy /usr/local/bin/

# Cleanup default dconf entries first.
dconf reset -f "/org/gnome/gedit/"
dconf reset -f "/org/gnome/deja-dup/"
dconf reset -f "/org/gnome/orca/"
dconf reset -f "/com/canonical/indicator/"
dconf reset -f "/com/canonical/unity/"
dconf reset -f "/org/gnome/nm-applet/eap/89d72cf6-f6d3-3e78-bfb2-53720551881b/"
dconf reset -f "/org/gnome/settings-daemon/plugins/housekeeping/"
dconf reset -f "/org/gnome/settings-daemon/plugins/xsettings/"

# Importing dconf preferences.
dconf load / < .prefs/ubuntu-dconf.txt
# Exporting dconf preferences.
# dconf dump / > .prefs/ubuntu-dconf.txt

# Travis.
sudo gem install travis

# Android Studio fixes.
echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p --system

# Ubuntu and Android Emulators.
sudo apt install qemu-kvm
sudo adduser "$(whoami)" kvm
sudo chown "$(whoami)" /dev/kvm

# https://stackoverflow.com/questions/42831999/android-studio-2-3-ubuntu-16-10-emulator-do-not-start
sudo apt-get install lib64stdc++6:i386 mesa-utils
sudo apt-get install mesa-utils

cd "$ANDROID_HOME/emulator/lib64" || exit
mv libstdc++/ libstdc++.bak
ln -s /usr/lib64/libstdc++.so.6 libstdc++
cd -

# Pidcat.
git clone git@github.com:JakeWharton/pidcat.git ~/.pidcat

# Cleaning up.
sudo apt-get update
sudo apt-get autoremove
sudo apt-get autoclean
