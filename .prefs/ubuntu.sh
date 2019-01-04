#!/bin/bash
set -euo pipefail

# Gradle
sudo rm -rf /opt/gradle/
sudo mkdir -p /opt/gradle/
wget -q -O gradle.zip https://services.gradle.org/distributions/gradle-5.1-all.zip
sudo unzip -q -d /opt/gradle gradle.zip
rm gradle.zip

# Git.
sudo apt-get install git
curl https://raw.githubusercontent.com/kamranahmedse/git-standup/master/installer.sh | sudo sh

# Tree.
sudo apt-get install tree

# Htop.
sudo apt-get install htop

# Hub for GitHub.
sudo snap install --classic hub
sudo snap refresh

# Go-Jira
sudo wget -q https://github.com/Netflix-Skunkworks/go-jira/releases/download/v1.0.20/jira-linux-386 -O /usr/local/bin/jira
sudo chmod +x /usr/local/bin/jira

# Phraseapp.
sudo wget -q https://github.com/phrase/phraseapp-client/releases/download/1.12.4/phraseapp_linux_amd64 -O /usr/local/bin/phraseapp
sudo chmod +x /usr/local/bin/phraseapp

# Ack.
sudo apt-get install ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# Bat.
wget -q -O bat.deb https://github.com/sharkdp/bat/releases/download/v0.9.0/bat_0.9.0_amd64.deb && sudo dpkg -i bat.deb && rm bat.deb

# Youtube-dl.
sudo wget -q https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
sudo chmod +x /usr/local/bin/youtube-dl

# Images.
sudo apt-get install imagemagick

# Count Lines of Code.
sudo apt-get install cloc

# Z.
sudo wget -q https://raw.githubusercontent.com/rupa/z/master/z.sh -O /etc/profile.d/z.sh

# Speedtest.
sudo apt-get install speedtest-cli

# Shellcheck.
sudo apt-get install shellcheck

# Diff-so-fancy.
wget -q https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -O /usr/local/bin/diff-so-fancy
chmod +x /usr/local/bin/diff-so-fancy

# Pidcat.
rm -rf "$HOME/.pidcat"
git clone git@github.com:JakeWharton/pidcat.git "$HOME/.pidcat"

###
 # From this point downwards it's OS specific things.
###

# Thunderbird.
sudo add-apt-repository -y -u ppa:mozillateam/ppa
sudo apt-get install thunderbird

# Google Drive.
sudo add-apt-repository -y -u ppa:alessandro-strada/ppa
sudo apt-get install google-drive-ocamlfuse

# Cryptomator.
sudo add-apt-repository -y -u ppa:sebastian-stenzel/cryptomator
sudo apt-get install cryptomator

# Pcregrep for grepping multilines (by default on Mac)
sudo apt-get install pcregrep

# Remove crap.
sudo apt-get purge nano gedit rhythmbox unity-lens-shopping brasero brasero-common unity-lens-video unity-lens-music totem-gstreamer totem-common brasero deja-dup gnome-orca
gsettings set com.canonical.Unity.Lenses disabled-scopes "['more_suggestions-amazon.scope', 'more_suggestions-u1ms.scope', 'more_suggestions-populartracks.scope', 'music-musicstore.scope', 'more_suggestions-ebay.scope', 'more_suggestions-ubuntushop.scope', 'more_suggestions-skimlinks.scope']"

# Java.
sudo add-apt-repository -y -u ppa:openjdk-r/ppa
sudo apt-get install openjdk-8-jdk

# Music.
sudo apt-get install vlc

# Filezilla.
sudo apt-get install filezilla

# Xclip (Copy paste).
sudo apt-get install xclip

# Sublime 3.
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Clone Sublime settings.
rm -rf "$HOME/.config/sublime-text-3/"
git clone git@github.com:vanniktech/config-sublime3.git "$HOME/.config/sublime-text-3"

# MP3 Handler for sox.
sudo apt-get install libsox-fmt-mp3

# Cleanup default dconf entries first.
dconf reset -f "/org/gnome/gedit/"
dconf reset -f "/org/gnome/rhythmbox/"
dconf reset -f "/org/gnome/deja-dup/"
dconf reset -f "/org/gnome/orca/"
dconf reset -f "/com/canonical/indicator/"
dconf reset -f "/com/canonical/unity/"
dconf reset -f "/org/gnome/nm-applet/eap/89d72cf6-f6d3-3e78-bfb2-53720551881b/"
dconf reset -f "/org/gnome/settings-daemon/plugins/housekeeping/"
dconf reset -f "/org/gnome/settings-daemon/plugins/xsettings/"

# Importing dconf preferences.
dconf load / < "$HOME/.prefs/ubuntu-dconf.txt"
# Exporting dconf preferences.
# dconf dump / > "$HOME/.prefs/ubuntu-dconf.txt"

# Android Studio fixes.
grep -q -F 'fs.inotify.max_user_watches = 524288' /etc/sysctl.conf || echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p --system

# Simulator (Ubuntu 18.04 and kvm).
sudo apt install qemu-kvm
sudo adduser "$(whoami)" kvm
sudo chown "$(whoami)" /dev/kvm

# Install missing dependencies - https://stackoverflow.com/questions/42831999/android-studio-2-3-ubuntu-16-10-emulator-do-not-start
sudo apt-get install lib64stdc++6:i386 mesa-utils

# Fix some internals
cd "$ANDROID_HOME/emulator/lib64" || exit
mv libstdc++/ libstdc++.bak
ln -s /usr/lib64/libstdc++.so.6 libstdc++
cd -

# Cleaning up.
sudo apt-get update
sudo apt-get autoremove --purge
sudo apt-get autoclean
