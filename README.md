# Setting up a new Mac

This repository contains personal dotfiles and scripts for setting up a new Mac, inspired by [Nina Zakharenko](https://github.com/nnja/new-computer).

## Useful resources:

- [How to Set Up Your MacBook for Web Development in 2020](https://medium.com/better-programming/setting-up-your-mac-for-web-development-in-2020-659f5588b883#d118)
- [Boost Your Command-Line Productivity With Fuzzy Finder](https://medium.com/better-programming/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d)
- [Homebrew](https://brew.sh/)

## Install from script

Note that [Homebrew](https://brew.sh/) requires [XCode](https://developer.apple.com/xcode/). To download the CLT tools for XCode, run the following command:

```sh
xcode-select --install
```

To setup your new Mac, run the following command:

```sh
bash -c "`curl -L https://git.io/mac-setup`"
```

This will run the following script:

```sh
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
brew cask install iterm2
brew cask install dash
brew cask install docker

### Command line tools - install new ones, update others to latest version
brew install fzf
brew install git
brew install tldr
brew install todo-txt
brew install tree
brew install wget
brew install zsh

### Productivity
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome

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

# Dock: Remove autohide-delay
defaults write com.apple.dock autohide-delay -float 0

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
brew install zsh-syntax-highlighting
brew install zsh-history-substring-search
brew install zsh-autosuggestions



###################
# Updating .zshrc #
###################

cat <<'EOT' >> ~/.zshrc

# Activate Powerlevel10k theme
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# Activate zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Activate zsh-history-substring-search
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

# Activate zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set pyenv-compatible PATH
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOT

# Installing fuzzy completion alias and key bindings for fzf
$(brew --prefix)/opt/fzf/install


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
```

## Manual setup

The following steps are performed manually:

### iTerm2

- _iTerm2 → Profiles → General_
  - [x] Other Actions → Import JSON profiles
- _iTerm2 → Preferences → General_
  - [x] Load preferences from custom folder (initialise empty folder)
  - [x] Save changes to folder when iTerm2 quits
  - [x] Save current settings
- Change bright black to lighter colour for `zsh-autosuggestions`.

### Powerlevel10k

- Uncomment `load`, `disk_usage`, `ram`, `ip` (keep only download/upload speed) and `battery` in ` typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS`, move to appropriate places.

### System Preferences

- _System Preferences → Keyboard_
  - Press Fn key to: Show Control Strip
- _System Preferences → Keyboard → Customise Control Strip_
  - Delete Siri from Touch Bar
- _System Preferences → Trackpad_
  - [x] Secondary click
  - [x] Tap to click
- Change where screenshots are saved: _Screenshot → Options → Save to._

### Dash

- Download docs for:
  - Python
  - R
  - JavaScript
  - HTML
  - CSS
- Download cheat sheets for:
  - git

### Visual Studio Code

- _Open Code → Preferences → Settings_:
  - `terminal.integrated.fontFamily`, set the value to `MesloLGS NF`
  - [x] `files.trimTrailingWhitespace`
  - [x] `editor.formatOnSave`
- [Shell command:](https://code.visualstudio.com/docs/setup/mac) Install 'code' command in PATH
- Install the following extensions:
  - Dracula Official
  - GitLens
  - Todo Tree
  - Rainbow Brackets
  - Python
  - Python Docstring Generator
  - ESLint
  - Prettier
  - Svelte for VS Code

### Oh My Zsh

- `plugins=(git alias-finder jsontools)`
- If you notice your shell is slow when pasting text into it, you might want to uncomment this line in your `.zshrc`: `# DISABLE_MAGIC_FUNCTIONS=true`.
- Add alias for `todo.txt-cli` in `.zshrc`: `alias t="todo.sh"`

#### `zsh-history-substring-search`

- _Key bindings:_

```sh
# Add to .zshrc
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
```

#### `fzf`

- See [Boost Your Command-Line Productivity With Fuzzy Finder](https://medium.com/better-programming/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d#e770) for an excellent guide to `fzf`.
- Fix problem with Alt + C by adding `bindkey "ç" fzf-cd-widget` to `.zshrc`.
- `fzf` binds `**` to fuzzy autocompletion, which conflicts with [globbing](http://zsh.sourceforge.net/Intro/intro_2.html). To change this, set `export FZF_COMPLETION_TRIGGER='**'` in `.zshrc` and change `**` to whatever you like.
- **Optional:** Useful key bindings for `fzf`:

```sh
# Toggle preview window visibility with '?'
fzf --bind '?:toggle-preview'
# Select all entries with 'CTRL-A'
fzf --bind 'ctrl-a:select-all'
# Copy the selected entries to the clipboard with 'CTRL-Y'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
# Open the selected entries in vim with 'CTRL-E'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
#Open the selected entries in vscode with 'CTRL-V'
--bind 'ctrl-v:execute(code {+})'
```

- **Optional:** Options can be added to `$FZF_DEFAULT_OPTS` so that they are always applied, not only to `fzf` but also when using key bindings and fuzzy completion.

```sh
# Add to .zshrc
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--height=80%
--multi
--preview-window=:hidden
--preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200'
--color='hl:148,hl+:154,pointer:032,marker:010,bg+:237,gutter:008'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
"
```

- Note that the options above require `bat`, which can be install via `brew install bat`. **WARNING:** `bat` installation takes a _long_ time.
