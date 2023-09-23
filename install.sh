#!/bin/bash

# Redirect standard error to install.log
exec 2>install.log

# Exit immediately if a command exits with a non-zero status
set -e

# Copy .vimrc to the appropriate location
cp .vimrc ~/.vimrc

if grep -qi Microsoft /proc/version; then
    echo "Skipping font installation on WSL"
elif fc-list | grep -q "JetBrains Mono"; then
    echo "JetBrains Mono font is already installed."
else
    # Install JetBrains Mono font
    echo "Installing JetBrains Mono font..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"
    echo "JetBrains Mono font installation complete!"
fi

BASHRC_CONTENT=$(cat ".bashrc")
# Check if .bashrc already contains the content
if ! grep -qF "$BASHRC_CONTENT" "$HOME/.bashrc"; then
    # Append content from your dotfiles to .bashrc with a new line
    echo "Configure bashrc"
    echo -e "\n$BASHRC_CONTENT" >>"$HOME/.bashrc"

else
    echo "Bashrc already configured"
fi
echo "Complete!"
