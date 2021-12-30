#!/bin/bash

source _utils.sh

# ------------------------------------------------------------------------------
e_pending "Setting defaults"
# ------------------------------------------------------------------------------

get_consent "Finder: Show status bar"
if has_consent; then
  e_pending "Finder: Show status bar"
  defaults write com.apple.finder ShowStatusBar -bool true
fi

get_consent "Finder: Keep folders on top when sorting by name"
if has_consent; then
  e_pending "Finder: Keep folders on top when sorting by name"
  defaults write com.apple.finder _FXSortFoldersFirst -bool true
fi

get_consent "Finder: Use list view by default"
if has_consent; then
  e_pending "Finder: Use list view by default"
  defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
fi

get_consent "Finder: Allow quitting via ⌘ + Q (doing so will also hide desktop icons)"
if has_consent; then
  e_pending "Finder: Allow quitting via ⌘ + Q (doing so will also hide desktop icons)"
  defaults write com.apple.finder QuitMenuItem -bool true
fi

# For other paths, use `PfLo` and `file:///full/path/here/`
get_consent "Finder: Set Desktop as the default location for new Finder windows"
if has_consent; then
  e_pending "Finder: Set Desktop as the default location for new Finder windows"
  defaults write com.apple.finder NewWindowTarget -string "PfDe"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
fi

get_consent "Finder: Set Desktop as the default location for new Finder windows"
if has_consent; then
  e_pending "Finder: Set Desktop as the default location for new Finder windows"
  defaults write com.apple.finder NewWindowTarget -string "PfDe"
  defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"
fi

get_consent "Finder: Display full POSIX path as window title"
if has_consent; then
  e_pending "Finder: Display full POSIX path as window title"
  defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
fi

get_consent "Dock: Set the icon size of Dock items to 36 pixels"
if has_consent; then
  e_pending "Dock: Set the icon size of Dock items to 36 pixels"
  defaults write com.apple.dock tilesize -int 36
fi

get_consent "Dock: Automatically hide"
if has_consent; then
  e_pending "Dock: Automatically hide"
  defaults write com.apple.dock autohide -bool true
fi

get_consent "Dock: Only show open applications"
if has_consent; then
  e_pending "Dock: Only show open applications"
  defaults write com.apple.dock static-only -bool true
fi

get_consent "Dock: Minimize windows into their application’s icon"
if has_consent; then
  e_pending "Dock: Minimize windows into their application’s icon"
  defaults write com.apple.dock minimize-to-application -bool true
fi

get_consent "Dock: Remove autohide-delay"
if has_consent; then
  e_pending "Dock: Remove autohide-delay"
  defaults write com.apple.dock autohide-delay -float 0
fi

get_consent "Global: Show all filename extensions"
if has_consent; then
  e_pending "Global: Show all filename extensions"
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true
fi

get_consent "Global: Disable auto-correct"
if has_consent; then
  e_pending "Global: Disable auto-correct"
  defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
fi

get_consent "Global: Use function F1, F2, etc. keys as standard function keys"
if has_consent; then
  e_pending "Global: Use function F1, F2, etc. keys as standard function keys"
  defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true
fi

get_consent "Global: Disable Notification Center and remove the menu bar icon"
if has_consent; then
  e_pending "Global: Disable Notification Center and remove the menu bar icon"
  launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null
fi

get_consent "Screensaver: Require password immediately after sleep or screen saver begins"
if has_consent; then
  e_pending "Screensaver: Require password immediately after sleep or screen saver begins"
  defaults write com.apple.screensaver askForPassword -int 1
  defaults write com.apple.screensaver askForPasswordDelay -int 0
fi