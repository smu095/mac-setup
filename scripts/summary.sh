#!/bin/bash

source _utils.sh

# ------------------------------------------------------------------------------
e_pending "Creating summary"
# ------------------------------------------------------------------------------

echo "\r"

# ------------------------------------------------------------------------------
e_pending "Checking folder creation and required tools"
# ------------------------------------------------------------------------------
# Test if ~/Development folder has been created successfully
e_success "Default commands changed successfully"
if has_path "Development"; then
  e_success "~/Development folder exists"
else
  e_failure "~/Development not created"
fi

# Test requirements
test_command "xcode-select"
test_command "brew"

echo "\r"

# ------------------------------------------------------------------------------
e_pending "Checking tools and brews"
# ------------------------------------------------------------------------------

# Test tools, brews and casks
test_command "node"
test_command "npm"
test_nvm
test_command "yarn"
test_command "r"
test_command "python"

test_command "git"
test_command "fzf"
test_command "tree"
test_command "wget"

echo "\r"

# ------------------------------------------------------------------------------
e_pending "Checking apps"
# ------------------------------------------------------------------------------

test_app "1Password 7"
test_app "Alfred 4"
test_app "AltTab"
test_app "Brave Browser"
test_app "Figma"
test_app "Firefox"
test_app "Google Chrome"
test_app "iTerm"
test_app "QGIS"
test_app "Rectangle"
test_app "RStudio"
test_app "Slack"
test_app "Sourcetree"
test_app "Spotify"
test_app "Visual Studio Code"

echo "\r"

# ------------------------------------------------------------------------------
e_pending "Checking zsh"
# ------------------------------------------------------------------------------

# Test zsh and plugins
test_command "zsh"
test_path ".oh-my-zsh"
test_brew "powerlevel10k"
test_brew "zsh-autosuggestions"
test_brew "zsh-syntax-highlighting"

e_success "Optimisation commands have been run"

echo "\r"

e_settled "Congratulations! Installation complete"