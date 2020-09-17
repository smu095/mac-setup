# Setting up a new Mac

This repository contains personal dotfiles and scripts for setting up a new Mac, inspired by [Nina Zakharenko](https://github.com/nnja/new-computer).

## Install from script

Open your terminal and run the following command:

```sh
bash -c "`curl -L https://git.io/mac-setup`"
```

This command runs the following script:

```sh
# Copy and paste final script here.
```

## Manual setup

The following steps are performed manually:

### iTerm2

- iTerm2 → Preferences → General
  - [x] Load preferences from custom folder
  - [x] Save changes to folder when iTerm2 quits
- Change bright black to lighter colour for `zsh-autosuggestions`.

### System Preferences

- System Preferences → Keyboard
  - Press Fn key to: Show Control Strip
- System Preferences → Keyboard → Customise Control Strip
  - Delete Siri from Touch Bar
- System Preferences → Trackpad
  - [x] Secondary click
  - [x] Tap to click
- Change where screenshots are saved: Screenshot → Options → Save to.

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