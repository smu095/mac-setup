#!/bin/bash

source _utils.sh

# ------------------------------------------------------------------------------
e_pending "App-specific options"
# ------------------------------------------------------------------------------

get_consent "VS Code: Enable key-repeating"
if has_consent; then
  e_pending "VS Code: Enable key-repeating"
  defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
fi

get_consent "iTerm2: Don’t display the annoying prompt when quitting"
if has_consent; then
  e_pending "iTerm2: Don’t display the annoying prompt when quitting"
  defaults write com.googlecode.iterm2 PromptOnQuit -bool false
fi