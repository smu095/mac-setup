echo "Mac OS Install Setup Script"
echo "by Sean Meling Murray"
echo "(adapted from https://github.com/nnja/new-computer)"

###################
# Installing Brew #
###################

echo "Installing brew..."

if test ! $(which brew)
then
    ## Don't prompt for confirmation when installing homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi

# Latest brew, install brew cask
brew upgrade
brew update
brew tap caskroom/cask

####################
# Install via Brew #
####################

echo "Starting brew app install..."

### Window Management
brew cask install rectangle

### Developer Tools
brew cask install iterm2
brew cask install dash

### Command line tools - install new ones, update others to latest version
brew install git
brew install wget
brew install zsh
brew install tree

### Python
brew install python
brew install pyenv

### Dev Editors 
brew cask install visual-studio-code

### Productivity
brew cask install google-chrome
brew cask install firefox
brew cask install dropbox

### Chat / Video Conference
brew cask install slack
brew cask install microsoft-teams
brew cask install signal

### Music
brew cask spotify

### Run Brew Cleanup
brew cleanup