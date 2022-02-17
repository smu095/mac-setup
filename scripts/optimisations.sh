#!/bin/bash

source _utils.sh

# ------------------------------------------------------------------------------
e_pending "Running optimisations"
# ------------------------------------------------------------------------------

if has_command "zsh"; then
  if has_path ".oh-my-zsh"; then
    e_pending "Updating oh-my-zsh"
    $ZSH/tools/upgrade.sh
    test_path ".oh-my-zsh"
  fi
fi

if has_command "brew"; then
  e_pending "Optimizing Homebrew"
  brew update && brew upgrade && brew doctor && brew cleanup
fi