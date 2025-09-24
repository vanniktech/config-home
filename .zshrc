#!/bin/bash

# Workaround for linux.
os=$(uname)

if [[ "$os" == 'Linux' ]]; then
  source "$HOME/.zprofile" # For some reason this does not work out of the box.
fi

# Environment variables that need to be set from .zprofile:
# export ZSH=
# export ANDROID_HOME=
# export JAVA_HOME=
# export GITHUB_ACCESS_TOKEN=
# export MATCH_KEYCHAIN_PASSWORD=
# export FIREBASE_TOKEN=
# export DEEPL_TOKEN=
# export GOOGLE_DRIVE=

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bash:$HOME/bin:/usr/local/bin:$PATH

# Add some more.
export ANDROID_SDK=$ANDROID_HOME
export ANDROID_SDK_ROOT=$ANDROID_HOME
export CHANGELOG_GITHUB_TOKEN=$GITHUB_ACCESS_TOKEN
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$JAVA_HOME"

# Tell Android Lint to print the entire stacktrace.
export LINT_PRINT_STACKTRACE=true

# Give Emulator 3 seconds to concentracte before killing it.
export ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=3

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
export UPDATE_ZSH_DAYS=14

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
export HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export plugins=(zsh-autosuggestions)

# If available, init zsh.
if test -f "$ZSH/oh-my-zsh.sh"
then
  source "$ZSH/oh-my-zsh.sh"
fi

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

alias g=git
alias c=clear
alias cl="wc -l"
alias cat=bat
alias ll="ls -lH"

# German directory - https://stackoverflow.com/questions/1949976/where-to-find-dictionaries-for-other-languages-for-intellij/16278834#16278834
# Download from https://ftp.gnu.org/gnu/aspell/dict/0index.html
# `cd` into the directory and execute `./configure`
# aspell -l de dump master | aspell -l de expand | tr ' ' '\n' > de.dic

function typos {
  aspell --home-dir="$HOME" --personal="$HOME/.aspell/personal.dic" --dont-backup -t -c "$1"
}

if [[ "$os" == 'Linux' ]]; then
  alias diff="diff --color=always"

  # Add Gradle.
  export PATH="$PATH:/opt/gradle/bin/"

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
  if [ -n "${DISPLAY+x}" ]; then
    xmodmap -e 'keycode 118='
  fi
elif [[ "$os" == 'Darwin' ]]; then
  # Homebrew.
  eval "$(/opt/homebrew/bin/brew shellenv)"

  # Optionally, init z file.
  brew_prefix="$(brew --prefix)"
  z_path="$brew_prefix/etc/profile.d/z.sh"
  if test -f "$z_path"
  then
    source "$z_path"
  fi

  # Use gsed as sed.
  export PATH="$brew_prefix/opt/gnu-sed/libexec/gnubin:$PATH"

  alias gts3="cd \$HOME/Library/Application\\ Support/Sublime\\ Text\\ 3/"
  alias browser="open -n -b com.google.Chrome --args --profile-directory=\"Default\""
  alias sysclean="brew cleanup"

  # iOS related (converting svgs files to pdf files)
  function svgtopdf {
    cairosvg "$1" -o "${1/.svg/.pdf}"
  }

  function svgtopdf15 {
    cairosvg "$1" -s 1.5 -o "${1/.svg/.pdf}"
  }

  gem_home="$(ruby -e 'puts Gem.user_dir')"
  export GEM_HOME="$gem_home"
  export PATH="$PATH:$GEM_HOME/bin"
fi

# Copy last command from Terminal into the clipboard.
alias l="fc -ln -1 | sed '1s/^[[:space:]]*//' | awk 1 ORS=\"\" | pbcopy"

function clean {
  echo "$(tput setaf 2)Nuking all files in ~/.m2 that have not been accessed in the last 180 days$(tput sgr0)"
  find ~/.m2 -type "f" -atime +180 -delete

  echo "$(tput setaf 2)Nuking all empty directories in ~/.m2/$(tput sgr0)"
  find ~/.m2 -mindepth 1 -type d -empty -delete

  echo "$(tput setaf 2)Nuking all files in ~/Library/Developer/Xcode/Archives/$(tput sgr0)"
  rm -rf ~/Library/Developer/Xcode/Archives/

  echo "$(tput setaf 2)Nuking all dSYM files in ~/dev/$(tput sgr0)"
  find ~/dev/ -type "f" -name "*.dSYM.zip" -delete

  echo "$(tput setaf 2)Nuking all ipa files in ~/dev/$(tput sgr0)"
  find ~/dev/ -type "f" -name "*.ipa" -delete

  echo "$(tput setaf 2)Nuking all aab files in ~/dev/$(tput sgr0)"
  find ~/dev/ -type "f" -name "*.aab" -delete

  echo "$(tput setaf 2)Nuking all apk files in ~/dev/$(tput sgr0)"
  find ~/dev/ -type "f" -name "*.apk" -delete

  echo "$(tput setaf 2)Clean up gem$(tput sgr0)"
  gem cleanup

  echo "$(tput setaf 2)System dependent clean up$(tput sgr0)"
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
  find . -type "f" -name "$1" -and -not -path "*/.idea/*" -and -not -path "*/.git/*" -and -not -path "*/build/tmp/*" -and -not -path "*/build/intermediates/*" -and -not -path "*/build/generated/*" -and -not -path "*/build/classes/*"
}

function fd {
  find . -type d -name "$1" -and -not -path "*/.idea/*" -and -not -path "*/.git/*" -and -not -path "*/build/tmp/*" -and -not -path "*/build/intermediates/*" -and -not -path "*/build/generated/*" -and -not -path "*/build/classes/*"
}

function fsed {
  find . -name "$1" -exec sed -i "/$2/d" {} +
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

function cpd {
  cp "$1" "$HOME/Downloads"
}

# Nuke empty directories
function ned {
  find . -mindepth 1 -type d -empty -delete
}

# Git things.
function github_changelog_generator {
  git cliff --config ~/.config/git-cliff/cliff.toml
}

function b {
  git add --all && git commit -m "Backup $(date "+%Y%m%d-%H:%m:%S")"
}

function gd {
  diff-so-fancy < "$1" | less --tabs=4 -RFX
}

function o {
  remote="$(git config --get remote.origin.url)"
  cleanRemote=$(git config --get remote.origin.url | sed 's/git@//' | sed 's/.git$//' | sed 's/:/\//')
  browser "https://$cleanRemote" 2>/dev/null # Ignore any errors.
}

function dmb {
  git fetch -p && git branch --no-color -vv | grep ': gone' | awk '{print $1}' | grep -v '\*' | xargs -n 1 git branch -D
}

function gpr {
  git fetch origin pull/"$1"/head:"$1" && git checkout "$1"
}

function dab {
  git branch --no-color | grep -v '\*' | xargs git branch -D
}

function git_current_branch {
  git branch --show-current
}

function pb {
  g pho "$(git_current_branch)"
}

# Push first unpushed commit.
function pfuc {
  # Get the current branch.
  local current_branch
  current_branch=$(git_current_branch)

  local remote
  remote=$(git remote)

  local last_unsynced_commit
  last_unsynced_commit=$(git log "$remote/$current_branch.." --oneline --no-color | tail -n 1 | awk '{print $1}')

  if [ -n "$last_unsynced_commit" ]; then
    git push "$remote" "$last_unsynced_commit:$current_branch"
  else
    green=$(tput setaf 2)
    reset=$(tput sgr0)
    echo "${green}No last unpushed commit${reset}"
  fi
}

function phf {
  g phf origin "$(git_current_branch)"
}

function pnb() {
  # Get the current branch.
  local current_branch
  current_branch=$(git_current_branch)

  # Push the current branch.
  g phou "$current_branch"

  # Last commit message.
  local last_commit_message
  last_commit_message=$(git log -n 1 --pretty=format:'%s')

  local message
  if [ "$1" == "--wip" ]; then message=""; else message=$1; fi

  title=$(printf "%s\\n\\n%s" "$last_commit_message" "$message")

  if [[ "$*" == *"--wip" ]]; then
    hub pull-request --draft -m "$title" -F -
  else
    hub pull-request -m "$title" -F -
  fi
}

# Jira.
alias j=jira

if command -v jira &> /dev/null
then
  eval "$(jira --completion-script-zsh)"
fi

# Puts the commit message from the given branch if it's prefixed with a ticket number into the clipboard. e.g. AP-123, AP-123/blub, bug/AP-123-test
function cm {
  jira view "$(git_current_branch | sed 's/bug\///' | sed 's/feature\///' | cut -f1 -d"/" | cut -f1-2 -d"-")" --field=summary,issue \
    | head -n 2 \
    | sed 's/issue: //' \
    | sed 's/summary: //' \
    | sed 's/\[Android\] //' \
    | sed 's/\Android: //' \
    | awk 'NR%2{printf "%s: ",$0;next;} {printf "%s%s",toupper(substr($0, 0, 1)),substr($0, 2);next}' \
    | awk '!/[[:digit:]]$/ && !/[[:punct:]]$/ && NF{$NF=$NF"."}1' \
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

      number_of_upstreams=$(git remote | grep -c upstream)

      if [ "$number_of_upstreams" -gt 0 ] ; then
        # We are in a fork.
        git fa
        git mum
        pb
      else
        # Normal repository that we have access too.
        git up
      fi

      dmb

      # Go to the previous branch and ignore any errors. An error usually indicates that the branch was already merged.
      git checkout - 2>/dev/null

      git remote prune origin
    fi

    cd ~- || exit # Go to previous directory without echoing.
  done
}

alias od="g dsw --no-color > t && subl t"

# Gradle.
function gw {
  if command -v jira &> /dev/null; then
    gradle --configuration-cache "$@"
  elif test -f "$PWD/gradlew"; then
   ./gradlew --configuration-cache "$@"
  else
    .././gradlew --configuration-cache "$@"
  fi
}

alias gd="jps|grep -E 'KotlinCompileDaemon|GradleDaemon'"

function gws {
  gw --stop || true
  jps | grep -E 'KotlinCompileDaemon|GradleDaemon' | awk '{print $1}' | xargs kill -9 || true
  killall java || true
}

alias gwl="gw lintDebug"
alias gwr="gw generateResourceAccessorsForCommonMain"
alias gwu="gw dependencyUpdates --no-parallel"
alias gwt="gw testDebug --continue --tests *Test --fail-fast"
alias gwt2="gw testDebug --continue --tests *Test"
alias gwi="gw testDebug --tests *Integration --fail-fast"
alias gwad="gw assembleDebug --continue"
alias gwid="gw installDebug --continue"

gwtc() {
  gw testDebug --tests "*$1*"
}

# Ack shorthands.
alias ag="ack --gradle"
alias aj="ack --java"
alias ak="ack --kotlin"
alias ap="ack --properties"
alias aq="ack --sql"
alias ax="ack --xml"
alias ay="ack --yaml"
alias ai="ack --ios"

# T my favorite.
alias et="chmod +x t && ./t"

alias yt="yt-dlp --cookies-from-browser chrome -S \"res:1080,fps\""
alias yts="yt-dlp --cookies-from-browser chrome --write-subs --sub-langs \"es,en,zh-Hans\" -S \"res:1080,fps\""
function yt-mp3 {
  yt-dlp --cookies-from-browser chrome -f 'bestaudio' -x --audio-format mp3 "$1" -o '%(title)s.%(ext)s'
}

# Print Version.
function v {
  ios_version=$(ack MARKETING_VERSION "../${PWD##*/}.xcodeproj/project.pbxproj" --no-filename 2> /dev/null | head -n 1)
  gradle_catalogue_version=$(ack '^name = ' gradle/libs.versions.toml 2> /dev/null)
  gradle_properties_version=$(ack VERSION_NAME gradle.properties 2> /dev/null)
  app_build_gradle_version_name=$(ack 'versionName "' app/build.gradle 2> /dev/null)
  build_gradle_version_name=$(ack 'versionName "' build.gradle 2> /dev/null)
  app_build_gradle_kts_version_name=$(ack 'versionName = "' app/build.gradle.kts 2> /dev/null)
  build_gradle_kts_version_name=$(ack 'versionName = "' build.gradle.kts 2> /dev/null)
  build_gradle_name=$(ack "name: '" build.gradle 2> /dev/null)

  if [ -n "$ios_version" ]; then
    echo "$ios_version"
  elif [ -n "$gradle_catalogue_version" ]; then
    echo "$gradle_catalogue_version"
  elif [ -n "$gradle_properties_version" ]; then
    echo "$gradle_properties_version"
  elif [ -n "$app_build_gradle_version_name" ]; then
    echo "$app_build_gradle_version_name"
  elif [ -n "$build_gradle_version_name" ]; then
    echo "$build_gradle_version_name"
  elif [ -n "$app_build_gradle_kts_version_name" ]; then
    echo "$app_build_gradle_kts_version_name"
  elif [ -n "$build_gradle_kts_version_name" ]; then
    echo "$build_gradle_kts_version_name"
  elif [ -n "$build_gradle_name" ]; then
    echo "$build_gradle_name"
  else
    ack "versionName \"" "$PWD" || ack "name: \"[\\d]+" "$PWD"
  fi
}

# Android.
function androidpushmusic() {
  destination="/storage/emulated/0/Music/m/"
  echo "Pushing music from $PWD to $destination"
  adb shell mkdir -p "$destination"
  find . -name "*.mp3" -not -path '*/.*' -exec adb push "$PWD/{}" "$destination" \;
}

function androidfixemulators() {
  find "$HOME/.android/avd" -type f -name "*.ini" -exec sed -i 's/hw.audioInput=yes/hw.audioInput=no/g' {} \;
}

function androidkillemulators() {
  ps aux | ack qemu | awk '{print $2}' | xargs kill
  find "$HOME/.android/avd" -name "*.lock" -exec rm {} \;
}

function androidtakescreenshot() {
  local file_path
  file_name=${1:-android_screenshot_$(date +%s)}
  file_path="/sdcard/$file_name.png"

  adb -d shell screencap -p "$file_path" 2> /dev/null || adb -e shell screencap -p "$file_path"
  adb -d pull "$file_path" 2> /dev/null || adb -e pull "$file_path"
  adb -d shell rm "$file_path" 2> /dev/null || adb -e shell rm "$file_path"
  open "$PWD"
}

# https://stackoverflow.com/a/50618460/1979703
function androidrefreshview() {
  adball shell "service call activity 1599295570" > nul
}

function androidoverdraw() {
  local is_shown
  is_shown=$(adb -d shell getprop debug.hwui.overdraw 2> /dev/null || adb -e shell getprop debug.hwui.overdraw 2> /dev/null || adball shell getprop debug.hwui.overdraw | head -n 1)

  if [[ "$is_shown" == "show" ]]; then
    adball shell "setprop debug.hwui.overdraw false"
  else
    adball shell "setprop debug.hwui.overdraw show"
  fi

  androidrefreshview
}

function androidtouches() {
  local show_touches
  show_touches=$(adb -d shell settings get system show_touches 2> /dev/null || adb -e shell settings get system show_touches 2> /dev/null || adball shell settings get system show_touches | head -n 1)

  if [[ "$show_touches" == 1 ]]; then
    adball shell "settings put system show_touches 0"
  else
    adball shell "settings put system show_touches 1"
  fi

  androidrefreshview
}

function androidlayoutbounds() {
  local is_shown
  is_shown=$(adb -d shell getprop debug.layout 2> /dev/null || adb -e shell getprop debug.layout 2> /dev/null || adball shell getprop debug.layout | head -n 1)

  if [[ "$is_shown" == "true" ]]; then
    adball shell "setprop debug.layout hidden"
  else
    adball shell "setprop debug.layout true"
  fi

  androidrefreshview
}

function androidprofilerendering() {
  local is_shown
  is_shown=$(adb -d shell getprop debug.hwui.profile 2> /dev/null || adb -e shell getprop debug.hwui.profile 2> /dev/null || adball shell getprop debug.hwui.profile | head -n 1)

  if [[ "$is_shown" == "visual_bars" ]]; then
    adball shell "setprop debug.hwui.profile 0"
  else
    adball shell "setprop debug.hwui.profile visual_bars"
  fi

  androidrefreshview
}

function androiddevices() {
  adb devices 2>&1 | tail -n +2 | sed '/^$/d'
}

function androidscreenshotmodeenter() {
  adball shell "settings put global sysui_demo_allowed 1"
  adball shell "am broadcast -a com.android.systemui.demo -e command exit"
  adball shell "am broadcast -a com.android.systemui.demo -e command enter"
  adball shell "am broadcast -a com.android.systemui.demo -e command notifications -e visible false"
  adball shell "am broadcast -a com.android.systemui.demo -e command status -e bluetooth hidden -e volume hidden -e speakerphone false -e location false -e mute false -e alarm false -e eri false -e sync false -e tty false"
  adball shell "am broadcast -a com.android.systemui.demo -e command network -e wifi show -e level 4 -e mobile false -e datatype hidden -e airplane false -e carriernetworkchange false"
  adball shell "am broadcast -a com.android.systemui.demo -e command battery -e level 100 -e plugged false -e powersave false"
  adball shell "am broadcast -a com.android.systemui.demo -e command clock -e hhmm 1100"
}

function androidscreenshotmodeexit() {
  adball shell "am broadcast -a com.android.systemui.demo -e command exit"
}

function androidtype() {
  adball shell "input text '$1'"
}

function androidanimations() {
  local animation_value
  animation_value=$(adb -d shell settings get global transition_animation_scale 2> /dev/null || adb -e shell settings get global transition_animation_scale)

  if [[ "$animation_value" == "0.0" ]]; then
    adball shell "settings put global window_animation_scale 1.0"
    adball shell "settings put global transition_animation_scale 1.0"
    adball shell "settings put global animator_duration_scale 1.0"
  else
    adball shell "settings put global window_animation_scale 0.0"
    adball shell "settings put global transition_animation_scale 0.0"
    adball shell "settings put global animator_duration_scale 0.0"
  fi
}

function androiduninstall() {
  adb shell pm list packages | ack "$1" | awk -F ":" '{print $2}' | xargs -L 1 -I@ bash -c "echo -n 'Uninstalling @ ... ' && adb uninstall @"
}

function adball() {
  adb devices | grep -E '\t(device|emulator)' | cut -f 1 | xargs -J% -n1 -P5 adb -s % "$@"
}

function asdump() {
  jps -mv | grep studio | awk '{print $1}' | xargs jstack -l >> dump.txt
}

function backup() {
  # Backup Thunderbird.
  prefix=$(date "+%Y%m%d-")
  rm -rf -- *-Thunderbird.zip
  thunderbird_target="${prefix}Thunderbird.zip"
  zip -rq "$HOME/$thunderbird_target" "$HOME/Library/Thunderbird"
  echo "Created $thunderbird_target in $HOME"
}

function killgoogledrive() {
  ps aux | ack "Google Drive" | awk '{print $2}' | xargs kill
}

# We always want to start at the home directory.
cd || exit
