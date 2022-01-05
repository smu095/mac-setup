# Setting up a new Mac

**NOTE**: This README has not been updated to reflect the current setup. What follows is a description of the contents in the `deprecated` folder.

This repository contains personal dotfiles and scripts for setting up a new Mac, inspired by [Nina Zakharenko](https://github.com/nnja/new-computer). Aliases and macOS configuration heavily inspired by [Mathias's dotfiles](https://github.com/mathiasbynens/dotfiles).

## Useful resources:

- [How to Set Up Your MacBook for Web Development in 2020](https://medium.com/better-programming/setting-up-your-mac-for-web-development-in-2020-659f5588b883#d118)
- [Boost Your Command-Line Productivity With Fuzzy Finder](https://medium.com/better-programming/boost-your-command-line-productivity-with-fuzzy-finder-985aa162ba5d)
- [Homebrew](https://brew.sh/)
- [Madam, I'm yadm](https://dataand.me/posts/2021-12-30-madam-im-yadm/)
- [Making the M1 Leap](https://dataand.me/notes/2021-12-06-making-the-m1-leap/)
- [Setting Up A New Macbook Pro](https://www.garrickadenbuie.com/blog/setting-up-a-new-macbook-pro/)
- [mac-dev-setup (github.com/michaelschwobe)](https://github.com/michaelschwobe/mac-dev-setup)

## Install from script

Note that [Homebrew](https://brew.sh/) requires [XCode](https://developer.apple.com/xcode/). Depending on your operating system, you may or may not have XCode installed.

To download the CLT tools for XCode, run the following command:

```sh
xcode-select --install
```

To setup your new Mac, run the following command:

```sh
sh -c "`curl -L https://git.io/JU06o`"
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
brew install --cask rectangle

### Developer Tools
brew install python
brew install r
brew install node
brew install --cask docker
brew install --cask iterm2
brew install --cask rstudio
brew install --cask visual-studio-code

### Command line tools - install new ones, update others to latest version
brew install fzf
brew install git
brew install todo-txt
brew install tree
brew install wget
brew install zsh

### Productivity
brew install --cask 1password
brew install --cask alfred
brew install --cask alt-tab
brew install --cask dozer
brew install --cask dropbox
brew install --cask fantastical
brew install --cask firefox
brew install --cask google-chrome
brew install --cask slack

# Screensavers
brew install --cask aerial

### Music
brew install --cask spotify

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

# This symlink is required to make dot function work (see .aliases)
ln -sv "$PWD/mac-setup/dotfiles" ~


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
```

## Manual setup

The following steps are performed manually:

### Alfred

- Activate Powerpack.
- Install workflows:

  - [Can I Use](https://github.com/willfarrell/alfred-caniuse-workflow)
  - [Colors](http://www.packal.org/workflow/colors)
  - [DevDocs](https://github.com/yannickglt/alfred-devdocs)
  - [Fantastical](https://www.alfredapp.com/blog/productivity/dont-miss-a-date-with-fantastical-2-and-workflows/)
  - [Github Repos](https://github.com/edgarjs/alfred-github-repos)
  - [Kill Process](https://github.com/ngreenstein/alfred-process-killer)
  - [StackExchange Search](https://github.com/deanishe/alfred-stackexchange)

- Enable Google Suggest (_Examples > Google Suggest_).
- Add [iTerm2 integration](https://github.com/vitorgalvao/custom-alfred-iterm-scripts).

### 1Password

Install [Chrome extension](https://chrome.google.com/webstore/detail/1password-x-%E2%80%93-password-ma/aeblfdkhhhdcdjpifhhbdiojplfjncoa?hl=en).

### iTerm2

- _iTerm2 → Profiles → General_
  - [x] Other Actions → Import JSON profiles
- Change bright black to lighter colour for visibility when using `zsh-autosuggestions`.
- **Optional:** _iTerm2 → Preferences → General_
  - [x] Load preferences from custom folder (initialise empty folder)
  - [x] Save changes to folder when iTerm2 quits
  - [x] Save current settings

### Powerlevel10k

- [Powerlevel10K](https://github.com/romkatv/powerlevel10k) should automatically prompt you to download the Meslo Nerd font. If it doesn't, [download them](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) and install manually. After installation, set your font to **MesloLGS NF** in iTerm.
- Uncomment `battery` in ` typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS`, move to appropriate place.

### System Preferences

- _System Preferences → Keyboard_
  - Adjust Key Repeat and Delay Until Repeat to desired sensitivity.
  - Press Fn key to: Show Control Strips
  - Remap ⌘ + Space to Alfred, change Spotlight to ⌥ + Space.
- _System Preferences → Keyboard → Customise Control Strip_
  - Remove Siri from Touch Bar
- _System Preferences → Trackpad_
  - [x] Secondary click
  - [x] Tap to click
- Change where screenshots are saved: _Screenshot → Options → Save to._

### Visual Studio Code

- _Open Code → Preferences → Settings_:
  - `terminal.integrated.fontFamily`, set the value to `MesloLGS NF`
  - [x] `files.trimTrailingWhitespace`
  - [x] `editor.formatOnSave`
- [Shell command:](https://code.visualstudio.com/docs/setup/mac) Install 'code' command in PATH
- Install the following extensions:
  - Dracula Official
  - ESLint
  - GitLens
  - Prettier
  - Python
  - Python Docstring Generator
  - Rainbow Brackets
  - Svelte 3 Snippets
  - Svelte for VS Code
  - Svelte Intellisense
  - Todo Tree
  - vscode-icons

### Svelte

- To ensure that the Svelte plugin is used for autoformatting `.svelte` files, update your settings JSON. I use this:

```json
{
  "editor.formatOnSave": true,
  "[svelte]": {
    "editor.defaultFormatter": "svelte.svelte-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "workbench.colorTheme": "Dracula",
  "todo-tree.tree.showScanModeButton": false,
  "workbench.iconTheme": "vscode-icons",
  "files.trimTrailingWhitespace": true,
  "terminal.integrated.fontFamily": "MesloLGS NF"
}
```

### Oh My Zsh

- `plugins=(git alias-finder jsontools)`
- If you notice your shell is slow when pasting text into it, you might want to uncomment this line in your `.zshrc`: `# DISABLE_MAGIC_FUNCTIONS=true`.

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
--bind 'ctrl-v:execute(code {+})'
"
```

- Note that the options above require `bat`, which can be install via `brew install bat`. **WARNING:** `bat` installation takes a _long_ time on older versions of macOS.
