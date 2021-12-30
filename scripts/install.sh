#!/bin/bash

# Install xcode-select, brew and create dev-folders
source setup.sh

# Set sensible macOS defaults, install tools, brews and casks, set sensible app defaults
source defaults.sh
source tools.sh
source casks.sh
source app-defaults.sh

# Run updates and print installation summary
source optimisations.sh
source summary.sh