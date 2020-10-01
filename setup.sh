#!/bin/sh
#                    _           _        _ _
#  ___  _____  __   (_)_ __  ___| |_ __ _| | |
# / _ \/ __\ \/ /   | | '_ \/ __| __/ _` | | |
#| (_) \__ \>  <    | | | | \__ \ || (_| | | |
# \___/|___/_/\_\   |_|_| |_|___/\__\__,_|_|_|


echo "🍎 Mac OS Install Setup Script 🍎"
echo "by Sean Meling Murray"
echo "(adapted from https://github.com/nnja/new-computer)"

# Set the colours you can use
red=$(tput setaf 1)
green=$(tput setaf 2)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

# Resets the style
reset=$(tput sgr0)

# Colour-echo
cecho() {
  echo "${2}${1}${reset}"
  return
}

echo ""
cecho "###############################################" $red
cecho "#        DO NOT RUN THIS SCRIPT BLINDLY       #" $red
cecho "#         YOU'LL PROBABLY REGRET IT...        #" $red
cecho "#                                             #" $red
cecho "#              READ IT THOROUGHLY             #" $red
cecho "#         AND EDIT TO SUIT YOUR NEEDS         #" $red
cecho "###############################################" $red
echo ""

# Set continue to false by default
CONTINUE=false

echo ""
cecho "Have you read through the script you're about to run and " $red
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  cecho "Please go read the script, it only takes a few minutes" $red
  exit
fi

# Here we go. Ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###################
# Installing Brew #
###################

cecho "Installing brew..." $green

if test ! $(which brew); then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Latest brew, install brew cask
brew upgrade
brew update


####################
# Install via Brew #
####################

cecho "Installing brew apps..." $green

### Window Management
brew cask install rectangle

### Developer Tools
brew install python
brew install r
brew install node
brew cask install dash
brew cask install docker
brew cask install iterm2
brew cask install rstudio
brew cask install visual-studio-code

### Command line tools - install new ones, update others to latest version
brew install fzf
brew install git
brew install todo-txt
brew install tree
brew install wget
brew install zsh

### Productivity
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install slack

### Music
brew cask install spotify

### Run Brew Cleanup
brew cleanup


######################
# Mac specific setup #
######################

cecho "Setting sensible Apple defaults..." $green

# For VS Code: Enable key-repeating
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

# Finder: Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Finder: Display full POSIX path as window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 36

# Dock: Automatically hide and show
defaults write com.apple.dock autohide -bool true

# Dock: Only show open applications
defaults write com.apple.dock static-only -bool true

# Dock: Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Dock: Remove autohide-delay
defaults write com.apple.dock autohide-delay -float 0

# Global: Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Global: Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Global: Use function F1, F2, etc. keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# Global: Disable Notification Center and remove the menu bar icon
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Screensaver: Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# iTerm2: Don’t display the annoying prompt when quitting
defaults write com.googlecode.iterm2 PromptOnQuit -bool false


########################
# Installing Oh My Szh #
########################

cecho "Installing Oh My Zsh..." $green
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

brew install romkatv/powerlevel10k/powerlevel10k
brew install zsh-syntax-highlighting
brew install zsh-history-substring-search
brew install zsh-autosuggestions


####################################################
# Clone setup repo and create symlinks to dotfiles #
####################################################

mkdir -pv ~/Development/github && cd "$_" && git clone https://github.com/smu095/mac-setup.git
ln -sv "$PWD/mac-setup/dotfiles/.todo.cfg" ~
ln -sv "$PWD/mac-setup/dotfiles/.aliases" ~
ln -sv "$PWD/mac-setup/dotfiles/.gitconfig" ~


###################
# Updating .zshrc #
###################

cat <<'EOT' >> ~/.zshrc

# Sourcing aliases
source ~/.aliases

# Activate Powerlevel10k theme
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# Activate zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Activate zsh-history-substring-search
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Activate zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
EOT


####################
# Install complete #
####################

echo ""
cecho "Done!" $cyan
cecho "NOTE: Some of these changes require a logout/restart to take effect." $red
cecho "Do you want to restart your computer now? (y/n)" $red

if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
  sudo shutdown -r now
else
  echo "Okay! Remember to reset your computer later!"
fi