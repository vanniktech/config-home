#!/bin/bash
set -eo pipefail

zsh_plugins_path="$HOME/.oh-my-zsh/custom/plugins"

# SpeedRead oh-my-zsh plugin.
rm -rf "$zsh_plugins_path/speedread"
git clone git@github.com:pasky/speedread.git "$zsh_plugins_path/speedread"

# AutoSuggestions oh-my-zsh plugin.
rm -rf "$zsh_plugins_path/zsh-autosuggestions"
git clone git@github.com:zsh-users/zsh-autosuggestions.git "$zsh_plugins_path/zsh-autosuggestions"

# Update gem.
gem update --system

# Fastlane.
gem install fastlane --user-install
gem install bundler --user-install

# GitHub Changelog Generator.
gem install github_changelog_generator --user-install

# Kotlin Multiplatform.
gem install cocoapods-generate --user-install

# Clean up.
gem cleanup

# Souncloud Music Downloader.
# Usage scdl -l https://soundcloud.com/derobdachlose -f
pip3 install git+https://github.com/flyingrub/scdl --upgrade

# Vim syntax highlighting.
rm -rf "$HOME/.vim/pack/default/start/vim-polyglot"
mkdir -p "$HOME/.vim/pack/default/start/"
git clone https://github.com/sheerun/vim-polyglot "$HOME/.vim/pack/default/start/vim-polyglot"

# Amazon CDK.
npm install -g aws-cdk || npm update -g aws-cdk
