#!/bin/bash
set -euo pipefail

# Java / OpenJDK.
sudo add-apt-repository -y -u ppa:openjdk-r/ppa
sudo apt-get install openjdk-11-jdk

# Gradle.
sudo rm -rf /opt/gradle/ && \
  sudo mkdir -p /opt/gradle/ && \
  wget -q -O gradle.zip https://services.gradle.org/distributions/gradle-6.1-all.zip && \
  unzip -q gradle.zip && \
  sudo mv gradle-6.1/* /opt/gradle/ && \
  rm -rf gradle.zip gradle-6.1/

# Git.
sudo apt-get install git
wget -O - https://raw.githubusercontent.com/kamranahmedse/git-standup/master/installer.sh | sudo sh

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
sudo wget -q https://github.com/phrase/phraseapp-client/releases/download/1.15.1/phraseapp_linux_amd64 -O /usr/local/bin/phraseapp
sudo chmod +x /usr/local/bin/phraseapp

# Ack.
sudo apt-get install ack-grep
sudo dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

# Bat.
wget -q -O bat.deb https://github.com/sharkdp/bat/releases/download/v0.10.0/bat_0.10.0_amd64.deb && sudo dpkg -i bat.deb && rm bat.deb

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
sudo wget -q https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -O /usr/local/bin/diff-so-fancy
sudo chmod +x /usr/local/bin/diff-so-fancy

# Pidcat.
rm -rf "$HOME/.pidcat"
git clone git@github.com:JakeWharton/pidcat.git "$HOME/.pidcat"

# jq.
sudo apt-get install jq

# Postgres.
sudo apt install postgresql postgresql-contrib

###
 # From this point downwards it is OS specific things.
###

# Exfat.
sudo apt-get install exfat-utils

# Curl.
sudo apt-get install curl

# Oh-my-zsh.
rm -rf "$ZSH"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git checkout "$HOME/.zshrc"

# Git.
sudo apt-get install git

# Gem.
sudo apt-get install ruby-dev

# Python 3.
sudo apt-get install python3-pip

# Gimp.
sudo apt-get install gimp

# Inkscape.
sudo apt-get install inkscape

# Color picker.
sudo apt-get install gpick

# Slack.
sudo snap install --classic slack
sudo snap refresh

# Thunderbird.
sudo add-apt-repository -y -u ppa:mozillateam/ppa
sudo apt-get install thunderbird

# Cryptomator.
sudo add-apt-repository -y -u ppa:sebastian-stenzel/cryptomator
sudo apt-get install cryptomator

# Pcregrep for grepping multilines (by default on Mac)
sudo apt-get install pcregrep

# Music.
sudo apt-get install vlc

# Filezilla.
sudo apt-get install filezilla

# Xclip (Copy paste).
sudo apt-get install xclip

# Sublime 3.
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# Clone Sublime settings.
rm -rf "$HOME/.config/sublime-text-3/"
git clone git@github.com:vanniktech/config-sublime3.git "$HOME/.config/sublime-text-3"

# MP3 Handler for sox.
sudo apt-get install libsox-fmt-mp3

# Powertop
sudo apt-get install powertop

# Dconf-editor.
sudo apt-get install dconf-editor

# Remove everything gnome related that I do not need.
sudo apt-get purge gnome-calculator gnome-robots gnome-tetravex gnome-taquin gnome-music gnome-nibbles gnome-orca gnome-system-log gnome-mahjongg gnome-mines gnome-sudoku gnome-chess gnome-contacts gnome-klotski gnome-maps gnome-todo* flashplugin-installer

# Remove other crap that I do not need.
sudo apt-get purge totem* nano gedit rhythmbox brasero* deja-dup cheese aisleriot playonlinux shotwell simple-scan firefox remmina libreoffice-* four-in-a-row five-or-more iagno lightsoff quadrapassel tali swell-foop

# rclone.
wget -qO- https://rclone.org/install.sh | sudo bash

# Remove unused unity desktop.
sudo apt-get purge unity*

# Remove unused display managers.
sudo apt-get purge sddm lightdm

# Netstat and other tools such as netstat, ifconfig, arp, etc.
sudo apt-get install net-tools

# Remove Amazon once and for all.
sudo rm -rf /usr/share/applications/ubuntu-amazon-default.desktop
sudo dpkg-divert --divert /usr/share/applications/ubuntu-amazon-default.desktop.diverted --local --rename /usr/share/applications/ubuntu-amazon-default.desktop

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
grep -q -F "fs.inotify.max_user_watches = 524288" /etc/sysctl.conf || echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p --system

# Simulator (Ubuntu 18.04 and kvm).
sudo apt install qemu-kvm
sudo adduser "$(whoami)" kvm
sudo chown "$(whoami)" /dev/kvm

# Install missing dependencies - https://stackoverflow.com/questions/42831999/android-studio-2-3-ubuntu-16-10-emulator-do-not-start
sudo apt-get install lib64stdc++6:i386 mesa-utils

# Set up my Android phone.
echo 'SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", MODE="0666", GROUP="plugdev"' | sudo tee /etc/udev/rules.d/51-android.rules
sudo udevadm control --reload-rules

# Cleaning up.
sudo apt-get update
sudo apt-get autoremove --purge
sudo apt-get autoclean

# Cleaning up some dot directories and files.
rm -rf "$HOME/.mozilla"
rm -rf "$HOME/.nano"
rm -rf "$HOME/.zcompdump*"

# Disable snapd service.
sudo systemctl stop snapd.service
sudo systemctl disable snapd.service

source unix.sh
