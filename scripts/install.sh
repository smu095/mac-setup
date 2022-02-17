#!/bin/bash

source _utils.sh

# Install xcode-select, brew, setup zsh and create dev-folders
source requirements.sh

# Set sensible macOS defaults, install tools, brews and casks, set sensible app defaults
source system-defaults.sh
source tools.sh
source casks.sh
source app-defaults.sh

# Run updates and print installation summary
source optimisations.sh
source summary.sh