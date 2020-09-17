#                    _           _        _ _ 
#  ___  _____  __   (_)_ __  ___| |_ __ _| | |
# / _ \/ __\ \/ /   | | '_ \/ __| __/ _` | | |
#| (_) \__ \>  <    | | | | \__ \ || (_| | | |
# \___/|___/_/\_\   |_|_| |_|___/\__\__,_|_|_|


echo "🍎 Mac OS Install Setup Script 🍎"
echo "by Sean Meling Murray"
echo "(adapted from https://github.com/nnja/new-computer)"

# Set the colours you can user
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
brew cask install iterm2
brew cask install dash
brew cask install docker

### Command line tools - install new ones, update others to latest version
brew install git
brew install wget
brew install tree
brew install zsh

### Productivity
brew cask install google-chrome
brew cask install firefox
brew cask install dropbox
brew install tldr

### Python
# NOTE: Following guide @ https://realpython.com/intro-to-pyenv/
brew install openssl readline sqlite3 xz zlib
brew install pyenv

### R
brew install r
brew cask install rstudio

### Node.js and npm
brew install node

### Dev Editors
brew cask install visual-studio-code

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

# Finder: Show all hidden files
defaults write com.apple.finder AppleShowAllFiles true

# Finder: Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Dock: Automatically hide and show
defaults write com.apple.dock autohide -bool true

# Dock: Only show open applications  
defaults write com.apple.dock static-only -bool true

# Dock: Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Global: Show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Global: Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Global: Use function F1, F2, etc. keys as standard function keys
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true


########################
# Installing Oh My Szh #
########################

cecho "Installing Oh My Zsh..." $green
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

brew install romkatv/powerlevel10k/powerlevel10k
echo "\n# Activate Powerlevel10k theme" >> ~/.zshrc
echo "source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme" >> ~/.zshrc

brew install zsh-syntax-highlighting
echo "\n# Activate zsh-syntax-highlighting" >> ~/.zshrc
echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc

brew install zsh-history-substring-search
echo "\n# Activate zsh-history-substring-search" >> ~/.zshrc
echo "source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh" >> ~/.zshrc

brew install zsh-autosuggestions
echo "\n# Activate zsh-autosuggestions" >> ~/.zshrc
echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

###################
# Updating .zshrc #
###################
 
echo "\n# Set pyenv-compatible PATH" >> ~/.zshrc
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.zshrc


####################
# Install complete #
####################

echo ""
cecho "Done!" $cyan
echo ""
echo ""
cecho "################################################################################" $white
echo ""
echo ""
cecho "NOTE: Some of these changes require a logout/restart to take effect." $red