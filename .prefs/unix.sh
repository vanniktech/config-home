#!/bin/bash
set -eo pipefail

zsh_plugins_path="$HOME/.oh-my-zsh/custom/plugins"

# SpeedRead oh-my-zsh plugin.
rm -rf "$zsh_plugins_path/speedread"
git clone git@github.com:pasky/speedread.git "$zsh_plugins_path/speedread"

# AutoSuggestions oh-my-zsh plugin.
rm -rf "$zsh_plugins_path/zsh-autosuggestions"
git clone git@github.com:zsh-users/zsh-autosuggestions.git "$zsh_plugins_path/zsh-autosuggestions"

# Fastlane.
sudo gem install fastlane -n /usr/local/bin
sudo gem install bundler -n /usr/local/bin

# Workaround for GitHub Changelog Generator.
# https://github.com/github-changelog-generator/github-changelog-generator/issues/1003
sudo gem install async -v '~> 1.29' -n /usr/local/bin

# GitHub Changelog Generator.
sudo gem install github_changelog_generator -n /usr/local/bin

# Kotlin Multiplatform.
sudo gem install cocoapods-generate -n /usr/local/bin

# Clean up.
sudo gem cleanup

# Souncloud Music Downloader.
# Usage scdl -l https://soundcloud.com/derobdachlose -f
pip3 install git+https://github.com/flyingrub/scdl --upgrade

# Vim syntax highlighting.
rm -rf "$HOME/.vim/pack/default/start/vim-polyglot"
mkdir -p "$HOME/.vim/pack/default/start/"
git clone https://github.com/sheerun/vim-polyglot "$HOME/.vim/pack/default/start/vim-polyglot"

# Amazon CDK.
npm install -g aws-cdk || npm update -g aws-cdk
