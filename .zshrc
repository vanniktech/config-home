#!/bin/bash

# Workaround for linux.
os=$(uname)

if [[ "$os" == 'Linux' ]]; then
  source "$HOME/.zprofile" # For some reason this does not work out of the box.
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bash:$HOME/bin:/usr/local/bin:$PATH

# Add some more.
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$JAVA_HOME"

# Path to your oh-my-zsh installation should be in the .zprofile file.

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
export ZSH_THEME="robbyrussell"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export plugins=(zsh-autosuggestions speedread)

source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'
export VISUAL="$EDITOR"
export PAGER="less -F -X"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias h=history
alias g=git
alias c=clear
alias cl="wc -l"

function typos {
  aspell --home-dir="$HOME" --personal=.aspell --dont-backup -t -c "$1"
}

if [[ "$os" == 'Linux' ]]; then
  # Add Gradle.
  export PATH="$PATH:/opt/gradle/gradle-5.0/bin"

  # Init z file.
  source /etc/profile.d/z.sh

  alias gts3="cd \$HOME/.config/sublime-text-3"
  alias browser="google-chrome --profile-directory=\"Profile 1\""
  alias sysclean="sudo apt-get update && sudo apt-get auto-remove && sudo apt-get auto-clean"

  # Emulate Mac commands.
  alias pbcopy="xclip -selection c"
  alias pbpaste="xclip -o"
  alias open="command xdg-open" # Command to open in parallel and do not have any logs.
  alias xargs="xargs --no-run-if-empty"

  # Pidcat alias since we need to install this one manually.
  alias pidcat="python \$HOME/.pidcat/pidcat.py"

  # Always execute this to cancel correctly.
  stty intr ^j

  # Disable insert key.
  xmodmap -e 'keycode 118='
elif [[ "$os" == 'Darwin' ]]; then
  # Init z file.
  source /usr/local/etc/profile.d/z.sh

  alias gts3="cd \$HOME/Library/Application\\ Support/Sublime\\ Text\\ 3/"
  alias browser="open -n -b com.google.Chrome --args --profile-directory=\"Default\""
  alias sysclean="brew cleanup"
fi

# Copy last command from Terminal into the clipboard.
alias l="fc -ln -1 | sed '1s/^[[:space:]]*//' | awk 1 ORS=\"\" | pbcopy"

function clean {
  local current_gradle_version
  current_gradle_version=$(gw --version | grep Gradle | awk '{print $2}')

  echo "\\033[0;32mNuking daemons other than $current_gradle_version\\033[0m"
  find ~/.gradle/daemon -maxdepth 1 | tail -n+2 | grep -v "$current_gradle_version" | xargs rm -rv

  echo "\\033[0;32mNuking notifications other than $current_gradle_version\\033[0m"
  find ~/.gradle/notifications -maxdepth 1 | tail -n+2 | grep -v "$current_gradle_version" | xargs rm -rv

  echo "\\033[0;32mNuking caches other than $current_gradle_version\\033[0m"
  find ~/.gradle/caches -maxdepth 1 | tail -n+2 | ack "[\\d\\.]{3,5}" | grep -v "$current_gradle_version" | xargs rm -rv

  echo "\\033[0;32mNuking all files in ~/.gradle that have not been accessed in the last 30 days\\033[0m"
  find ~/.gradle -type "f" -atime +30 -delete

  echo "\\033[0;32mNuking all empty directories in ~/.gradle/\\033[0m"
  find ~/.gradle -mindepth 1 -type d -empty -delete

  echo "\\033[0;32mNuking all files in ~/.m2 that have not been accessed in the last 30 days\\033[0m"
  find ~/.m2 -type "f" -atime +30 -delete

  echo "\\033[0;32mNuking all empty directories in ~/.m2/\\033[0m"
  find ~/.m2 -mindepth 1 -type d -empty -delete

  echo "\\033[0;32mClean up gem\\033[0m"
  sudo gem cleanup

  echo "\\033[0;32mSystem dependent clean up\\033[0m"
  sysclean
}

# https://github.com/robbyrussell/oh-my-zsh/issues/433
alias rake='noglob rake'

# http://unix.stackexchange.com/questions/130958/scp-wildcard-not-working-in-zsh
setopt nonomatch

# https://github.com/mattjj/my-oh-my-zsh/blob/master/history.zsh
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# Finding and doing things.

function f {
  find . -type "f" -name "$1" -and -not -path "*/build/tmp/*" -and -not -path "*/build/intermediates/*" -and -not -path "*/build/generated/*" -and -not -path "*/build/classes/*"
}

function fd {
  find . -type d -name "$1" -and -not -path "*/build/tmp/*" -and -not -path "*/build/intermediates/*" -and -not -path "*/build/generated/*" -and -not -path "*/build/classes/*"
}

function fs {
  f "$1" | xargs subl
}

function as {
  ack -l "$1" | xargs subl
}

function frm {
  f "$1" | xargs rm -rf
}

# Nuke empty directories
function ned {
  find . -mindepth 1 -type d -empty -delete
}

# Git things.
function o {
  remote="$(git config --get remote.origin.url)"
  cleanRemote=${${${${remote/git\@/}/.git/}/:/\/}/https:\/\//}
  browser "https://$cleanRemote"
}

function dmb {
  git fetch -p && git branch -vv | ack ': gone' | awk '{print $1}' | grep -v '\*' | sed -r "s/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | xargs -n 1 git branch -D
}

function gpr {
  git fetch origin pull/"$1"/head:"$1" && git checkout "$1"
}

function dab {
  git branch | grep -v '\*' | sed -r "s/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | xargs git branch -D
}

function git_current_branch {
  git branch | sed -n '/\* /s///p' | sed -r "s/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"
}

function pb {
  g pho "$(git_current_branch)"
}

function phf {
  g phf origin "$(git_current_branch)"
}

function pnb() {
  # Push the current branch.
  g phou "$(git_current_branch)"

  local last_commit_message
  last_commit_message=$(git log -n 1 --pretty=format:'%s')

  # Let's try to get a possible ticket by a convention of AB-0123456789:
  local jira_ticket_number
  jira_ticket_number=$(echo "$last_commit_message" | awk '/[A-Z]{2,3}-[0-9]+:/ {print $1}')

  # Remove the :
  local jira_ticket=${jira_ticket_number/:/}

  if [ ! "$jira_ticket" ];then
    title=$(printf "%s\\n\\n%s" "$last_commit_message" "$1")
  else
    title=$(printf "%s\\n\\nhttps://moovel.atlassian.net/browse/%s\\n\\n%s" "$last_commit_message" "$jira_ticket" "$1")
  fi

  hub pull-request -m "$title" -F -
}

# Jira.
alias j=jira
eval "$(jira --completion-script-zsh)"

# Puts the commit message from the given branch if it's prefixed with a ticket number into the clipboard. e.g. AP-123, AP-123/blub
function cm {
  jira view "$(git_current_branch | cut -f1 -d"/")" --field=summary,issue \
    | head -n 2 \
    | sed 's/issue: //' \
    | sed 's/summary: //' \
    | sed 's/\[Android\] //' \
    | sed 's/\Android: //' \
    | awk 'NR%2{printf "%s: ",$0;next;} {printf "%s%s",toupper(substr($0, 0, 1)),substr($0, 2);next}' \
    | awk '!/[[:punct:]]$/ && NF{$NF=$NF"."}1' \
    | tr -d "\\n" \
    | pbcopy
}

# Clear pull prune.
function cpp {
  green=$(tput setaf 2)
  reset=$(tput sgr0)

  for i in */; do
    cd "$i" || exit

    is_git_directory=$(find . -maxdepth 1 -type d -name ".git" | wc -l)

    if [ "$is_git_directory" -gt 0 ] ; then
      echo "${green}Clear Pull Pruning $i${reset}"

      git checkout master

      number_of_upstreams=$(git remote | ack -c upstream)

      if [ "$number_of_upstreams" -gt 0 ] ; then
        # We are in a fork.
        git fa
        git mum
        pb
      else
        # Normal repository that we have access too.
        git up
      fi

      git remote prune origin
      dmb

      # Go to the previous branch.
      git checkout -
    fi

    cd ~- || exit # Go to previous directory without echoing.
  done
}

alias od="g dw --no-color > t && subl t"

# Speedread the current content of the clipboard.
function speedread-clipboard {
  pbpaste | speedread -w 500
}

# Gradle.
alias gw="gradle"
alias gws="gradle --stop"
alias gwcb="gradle clean build"
alias gwcdl="gradle lintDebug"
alias gwdu="gradle dependencyUpdates"

gwtc() {
  gw testDebug --tests "*$1*"
}

# Ack shorthands.
alias ay="ack --yaml"
alias ayi="ack --yaml -i"
alias ax="ack --xml"
alias axi="ack --xml -i"
alias ak="ack --kotlin"
alias aki="ack --kotlin -i"
alias aj="ack --java"
alias aji="ack --java -i"
alias ag="ack --groovy"
alias agi="ack --groovy -i"

# Compress iamges.
alias ci="find . -name '*.png' -and -not -name '*.9.png' -exec pngquant --skip-if-larger --speed 1 -f --ext .png 256 {} \\;"

# T my favorite.
alias et="chmod +x t && ./t"

# Print Library Version from gradle.properties.
alias lv="ack VERSION_NAME gradle.properties | sed -En \"s/VERSION_NAME=//p\""

# Android.
function androidtakescreenshot() {
  local file_path
  file_path="/sdcard/$(date +%s).png"

  adb shell screencap -p "$file_path"
  adb pull "$file_path"
  adb shell rm "$file_path"
}

# https://stackoverflow.com/a/50618460/1979703
function androidrefreshview() {
  adb shell service call activity 1599295570 > nul
}

function androidoverdraw() {
  local is_shown
  is_shown=$(adb shell getprop debug.hwui.overdraw)

  if [[ "$is_shown" == "show" ]]; then
    adb shell setprop debug.hwui.overdraw false
  else
    adb shell setprop debug.hwui.overdraw show
  fi

  androidrefreshview
}

function androidtouches() {
  local show_touches
  show_touches=$(adb shell settings get system show_touches)

  if [[ "$show_touches" == 1 ]]; then
    adb shell settings put system show_touches 0
  else
    adb shell settings put system show_touches 1
  fi

  androidrefreshview
}

function androidlayoutbounds() {
  local is_shown
  is_shown=$(adb shell getprop debug.layout)

  if [[ "$is_shown" == "true" ]]; then
    adb shell setprop debug.layout hidden
  else
    adb shell setprop debug.layout true
  fi

  androidrefreshview
}

function backup() {
  local computer_name
  computer_name=${$(hostname)/.fritz.box/}

  # Delete possibly old backup.
  rm -rf $computer_name

  # Create folder named according to the computer.
  mkdir $computer_name

  # Start moving everything that's precious.
  cp "$HOME/.gradle/gradle.properties" "$computer_name"
  cp "$HOME/.zprofile" "$computer_name"
  cp -a "$HOME/.ssh" "$computer_name"
  cp -a "$HOME/.gnupg" "$computer_name" 2>/dev/null # Ignore any kind of errors.

  # For the time being I can't open source this - https://github.com/Netflix-Skunkworks/go-jira/issues/172
  cp -a "$HOME/.jira.d" "$computer_name"

  # Get all keystore files.
  find . -maxdepth 4 -not -path '*/\.*' -type "f" \( -iname \*.keystore ! -iname "debug.keystore" -or -iname \*.jks \) -exec cp {} $computer_name \; 2>/dev/null # Ignore any kind of errors.
}

# Others.
alias cat=bat

# We always want to start at the home directory.
cd || exit