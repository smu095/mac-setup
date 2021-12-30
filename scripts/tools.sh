source _utils.sh

# ------------------------------------------------------------------------------
e_pending "Checking brews"
# ------------------------------------------------------------------------------

declare -a brew_name=(
"node"
"r"
"python"
"fzf"
"git"
"tree"
"wget"
"zsh"
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
      brew install --cask $NAME
      test_cask "font-fira-code"
    fi
  fi
fi

# ------------------------------------------------------------------------------
e_pending "Checking for Node Version Manager"
# ------------------------------------------------------------------------------

test_nvm
if ! has_nvm; then
  get_consent "Install nvm (Node via nvm)"
  if has_consent; then
    e_pending "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    echo '# This loads nvm' >>! ~/.zshrc
    echo 'export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >>! ~/.zshrc
    test_nvm
  fi
fi

# ------------------------------------------------------------------------------
e_pending "Checking zsh-extensions and themes"
# ------------------------------------------------------------------------------

if has_command "zsh"; then
  test_path ".oh-my-zsh"
  if ! has_path ".oh-my-zsh"; then
    get_consent "Install oh-my-zsh"
    if has_consent; then
      e_pending "Installing oh-my-zsh"
      sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi
  fi
fi

if has_command "brew" && has_command "zsh"; then
  test_brew "powerlevel10k"
  if ! has_brew "powerlevel10k"; then
    get_consent "Install powerlevel10k (CLI theming)"
    if has_consent; then
      e_pending "Installing powerlevel10k"
      brew install romkatv/powerlevel10k/powerlevel10k
      echo '# Theme configuration: PowerLevel10K' >>! ~/.zshrc
      echo 'source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
      echo '# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.' >>! ~/.zshrc
      echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >>! ~/.zshrc
      p10k configure
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
      echo "# Fish shell-like fast/unobtrusive autosuggestions for Zsh." >> ~/.zshrc
      echo "source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
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
      echo "# Fish shell-like syntax highlighting for Zsh." >> ~/.zshrc
      echo "# Warning: Must be last sourced!" >> ~/.zshrc
      echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
      test_brew "zsh-syntax-highlighting"
    fi
  fi
fi