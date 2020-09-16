echo "Mac OS Install Setup Script"
echo "by Sean Meling Murray"
echo "(adapted from https://github.com/nnja/new-computer)"

# Set the colours you can user
red=$(tput setaf 1)
green=$(tput setaf 2)
# TODO: Add yellow

# Resets the style
reset=$(tput sgr0)

# Colour-echo
cecho() {
  echo "${2}${1}${reset}"
  return
}

# TODO: Add warning/continue prompt

###################
# Installing Brew #
###################

cecho "Installing brew..." $green

if test ! $(which brew)
then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
fi

# Latest brew, install brew cask
brew upgrade
brew update

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
brew install tree
brew install zsh

### Productivity
brew cask install google-chrome
brew cask install firefox
brew cask install dropbox

### Python
brew install python
brew install pyenv

### R
brew install r
brew cask install rstudio

### Dev Editors
brew cask install visual-studio-code

### Music
brew cask install spotify

### Run Brew Cleanup
brew cleanup

########################
# Installing Oh My Szh #
########################

# TODO: Figure out if you need to restart shell?

echo "Installing Oh My Zsh..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Powerlevel10k theme..."

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Restarting Zsh..."

exec zsh
