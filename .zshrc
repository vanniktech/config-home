# Workaround for linux.
unamestr=`uname`

if [[ "$unamestr" == 'Linux' ]]; then
  source ~/.zprofile # For some reason this does not work out of the box.
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
ZSH_THEME="robbyrussell"

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
plugins=(gradle sudo zsh-autosuggestions speedread)

source $ZSH/oh-my-zsh.sh

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
alias typos="aspell --home-dir=$HOME --personal=.aspell --dont-backup -t -c $1"

if [[ "$unamestr" == 'Linux' ]]; then
  # Init z file.
  . /etc/profile.d/z.sh

  alias gts3="cd $HOME/.config/sublime-text-3"
  alias xclip="xclip -selection c"
  alias open="command xdg-open" # Command to open in parallel and don't have any logs.

  # Copy last command from Terminal into the clipboard.
  alias l="fc -ln -1 | sed '1s/^[[:space:]]*//' | awk 1 ORS=\"\" | xclip"

  alias browser="google-chrome --profile-directory=\"Profile 1\""
  alias sysclean="sudo apt-get update && sudo apt-get auto-remove && sudo apt-get auto-clean"

  alias pidcat="python $HOME/.pidcat/pidcat.py"

  # Always execute this to cancel correctly.
  stty intr ^j

  # Alias xargs to simulate Mac behavior - to not run if empty.
  alias xargs="xargs --no-run-if-empty"
elif [[ "$unamestr" == 'Darwin' ]]; then
  # Init z file.
  . /usr/local/etc/profile.d/z.sh

  alias gts3="cd $HOME/Library/Application\ Support/Sublime\ Text\ 3/"

  # Copy last command from Terminal into the clipboard.
  alias l="fc -ln -1 | sed '1s/^[[:space:]]*//' | awk 1 ORS=\"\" | pbcopy"

  alias browser="open -n -b com.google.Chrome --args --profile-directory=\"Default\""
  alias sysclean="brew cleanup"
fi

alias clean="find ~/.gradle -type f -atime +30 -delete && find ~/.gradle -mindepth 1 -type d -empty -delete && sysclean"

eval $(thefuck --alias)

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

f() { find . -type f -name $1 -and -not -path "*/build/tmp/*" -and -not -path "*/build/intermediates/*" -and -not -path "*/build/generated/*" -and -not -path "*/build/classes/*" }
fd() { find . -type d -name $1 -and -not -path "*/build/tmp/*" -and -not -path "*/build/intermediates/*" -and -not -path "*/build/generated/*" -and -not -path "*/build/classes/*" }
fs() { subl $(f $1) }
fsod() { f $1 | sed "s/$1//" | xargs open }
frm() { rm -rf $(f $1) }

# Git things.
o() {
  remote="${$(git config --get remote.origin.url)}"
  cleanRemote=${${${${remote/git\@/}/.git/}/:/\/}/https:\/\//}
  browser "https://$cleanRemote"
}

dmb() {
  git fetch -p && git branch -vv | ack ': gone' | awk '{print $1}' | grep -v "*" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | xargs -n 1 git branch -D
}

gpr() {
  git fetch origin pull/$1/head:$1 && git checkout $1
}

dab() {
  git branch | grep -v '*' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | xargs git branch -D
}

pb() {
  g pho $(git branch | sed -n '/\* /s///p' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
}

phf() {
  g phf origin $(git branch | sed -n '/\* /s///p' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")
}

pnb() {
  # Push the current branch.
  g phou $(git branch | sed -n '/\* /s///p' | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g")

  lastCommitMessage=`git log -n 1 --pretty=format:'%s'`

  # Let's try to get a possible ticket by a convention of AB-0123456789:
  result=$(echo $lastCommitMessage | awk '/[A-Z]{2,3}-[0-9]+:/ {print $1}')

  # Remove the :
  cleanResult=${result/:/}

  if [ ! "$cleanResult" ];then
    title=$lastCommitMessage
  else
    # This is the only way. https://github.com/github/hub/issues/909
    title=$(printf "$lastCommitMessage\n\nhttps://moovel.atlassian.net/browse/$cleanResult")
  fi

  hub pull-request -m $title -F -
}

# Clear pull prune.
cpp() {
  green=`tput setaf 2`
  reset=`tput sgr0`

  for i in $PWD/**; do
    cd $i

    isGitDirectory=$(find . -maxdepth 1 -type d -name ".git" | wc -l)

    if [ $isGitDirectory -gt 0 ] ; then
      echo "${green}Clear Pull Pruning $i${reset}"

      git checkout master
      git up
      git remote prune origin

      dmb
    fi

    cd - # Go to previous directory.
  done
}

alias od="g dw --no-color > t && subl t"

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
alias ci="find . -name '*.png' -and -not -name '*.9.png' -exec pngquant --skip-if-larger --speed 1 -f --ext .png 256 {} \;"

# T my favorite.
alias et="chmod +x t && ./t"

# Print Library Version from gradle.properties.
alias lv="ack VERSION_NAME gradle.properties | sed -En \"s/VERSION_NAME=//p\""

# Android.
androidtakescreenshot() {
  filePath="/sdcard/$(date +%s).png"

  adb shell screencap -p $filePath
  adb pull $filePath
  adb shell rm $filePath
}

androidoverdraw() {
  isShown=$(adb shell getprop debug.hwui.overdraw)

  if [[ "$isShown" == 'show' ]]; then
    adb shell setprop debug.hwui.overdraw false
  else
    adb shell setprop debug.hwui.overdraw show
  fi
}

# We always want to start at the home directory.
cd