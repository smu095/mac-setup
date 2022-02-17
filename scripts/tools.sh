#!/bin/bash

source _utils.sh

# ------------------------------------------------------------------------------
e_pending "Checking brews"
# ------------------------------------------------------------------------------

declare -a brew_name=(
"python"
"fzf"
"git"
"tree"
"wget"
)

if has_command "brew"; then
  for i in "${!brew_name[@]}"; do
    NAME=${brew_name[$i]}
    test_brew "$NAME"
    if ! has_brew "$NAME"; then
      get_consent "brew install $NAME"
      if has_consent; then
        e_pending "Installing $NAME"
        brew install $NAME
        test_brew "$NAME"
      fi
    fi
  done
fi

if has_command "brew"; then
  test_cask "font-fira-code"
  if ! has_cask "font-fira-code"; then
    get_consent "Install font-fira-code (via brew)"
    if has_consent; then
      e_pending "Installing font-fira-code (via brew)"
      brew tap homebrew/cask-fonts
      brew install --cask font-fira-code
      test_cask "font-fira-code"
    fi
  fi
fi

echo ""

# ------------------------------------------------------------------------------
e_pending "Checking for Node Version Manager"
# ------------------------------------------------------------------------------

if ! has_nvm; then
  get_consent "Install Node Version Manager"
  if has_consent; then
    e_pending "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | /bin/bash
  fi
  get_consent "Install Node LTS (via nvm)"
  if has_consent; then
    e_pending "Installing Node LTS"
    source ~/.nvm/nvm.sh
    nvm install --lts
  fi
fi

echo ""

# ------------------------------------------------------------------------------
e_pending "Checking for yarn package manager"
# ------------------------------------------------------------------------------

if ! has_command "yarn"; then
  get_consent "Install yarn (via nvm)"
  if has_consent; then
    e_pending "Installing yarn"
    npm install --global yarn
    test_command "yarn"
  fi
fi

echo ""