#!/bin/bash

source _utils.sh

# ------------------------------------------------------------------------------
e_pending "Installing required tools"
# ------------------------------------------------------------------------------

if ! has_command "xcode-select"; then
  e_pending "Installing xcode-select (CLI tools)"
  xcode-select --install
  test_command "xcode-select"
fi

if ! has_command "brew"; then
  e_pending "Installing brew (Homebrew)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  brew doctor
  test_command "brew"
fi

# ------------------------------------------------------------------------------
e_pending "Creating folders"
# ------------------------------------------------------------------------------

if ! has_path "Development"; then
  get_consent "Create ~/Development folder and subdirectories (github, node, personal, r, resources, svelte)"
  if has_consent; then
    e_pending "Creating ~/Development folder and subdirectories"
    mkdir -p ~/Development/{github,node,personal,r,resources,svelte}
    test_path "Development"
  fi
fi
