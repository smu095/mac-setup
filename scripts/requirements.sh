#!/bin/zsh

# ------------------------------------------------------------------------------
e_pending "Installing required tools"
# ------------------------------------------------------------------------------

if ! has_command "xcode-select"; then
  e_pending "Installing xcode-select (CLI tools)"
  xcode-select --install
  test_command "xcode-select"
fi

if has_command "zsh"; then
  test_path ".oh-my-zsh"
  if ! has_path ".oh-my-zsh"; then
    get_consent "Install oh-my-zsh"
    if has_consent; then
      e_pending "Installing oh-my-zsh"
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
      test_path ".oh-my-zsh"
    fi
  fi
fi

if ! has_command "brew"; then
  e_pending "Installing brew (Homebrew)"
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo '# This adds brew to PATH' >>! $HOME/.zprofile
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>! $HOME/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew analytics off
  brew doctor
  test_command "brew"
fi

# ------------------------------------------------------------------------------
e_pending "Installing zsh-extensions and themes"
# ------------------------------------------------------------------------------

if has_command "brew" && has_command "zsh"; then
  test_brew "powerlevel10k"
  if ! has_brew "powerlevel10k"; then
    get_consent "Install powerlevel10k (CLI theming)"
    if has_consent; then
      e_pending "Installing powerlevel10k"
      brew install romkatv/powerlevel10k/powerlevel10k
      echo '# Theme configuration: PowerLevel10K' >>! $HOME/.zshrc
      echo "source $(brew --prefix)/opt/powerlevel10k/powerlevel10k.zsh-theme" >>! $HOME/.zshrc
      echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >>! $HOME/.zshrc
      echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >>! $HOME/.zshrc
      test_brew "powerlevel10k"
    fi
  fi
fi

if has_command "brew" && has_command "zsh"; then
  test_brew "zsh-autosuggestions"
  if ! has_brew "zsh-autosuggestions"; then
    get_consent "Install zsh-autosuggestions"
    if has_consent; then
      e_pending "Installing zsh-autosuggestions"
      brew install zsh-autosuggestions
      # TODO: Double check this
      echo "# Fish shell-like fast/unobtrusive autosuggestions for Zsh." >> $HOME/.zshrc
      echo "source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc
      test_brew "zsh-autosuggestions"
    fi
  fi
fi

if has_command "brew" && has_command "zsh"; then
  test_brew "zsh-syntax-highlighting"
  if ! has_brew "zsh-syntax-highlighting"; then
    get_consent "Install zsh-syntax-highlighting"
    if has_consent; then
      e_pending "Installing zsh-syntax-highlighting"
      brew install zsh-syntax-highlighting
      echo "# Fish shell-like syntax highlighting for Zsh." >> $HOME/.zshrc
      echo "# Warning: Must be last sourced!" >> $HOME/.zshrc
      echo "source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc
      test_brew "zsh-syntax-highlighting"
    fi
  fi
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
