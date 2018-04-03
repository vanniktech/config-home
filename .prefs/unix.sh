#!/bin/bash
set -euo pipefail

# SpeedRead oh-my-zsh plugin.
git clone https://github.com/pasky/speedread.git $ZSH_CUSTOM/plugins/speedread

# AutoSuggestions.
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions

# Fastlane
sudo gem install fastlane
