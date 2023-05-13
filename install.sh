#!/bin/bash

# Redirect standard error to install.log
exec 2>install.log

# Exit immediately if a command exits with a non-zero status
set -e

# Copy .vimrc to the appropriate location
cp .vimrc ~/.vimrc

echo "Dotfiles installation complete!"


# Install JetBrains Mono font
echo "Installing JetBrains Mono font..."

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/JetBrains/JetBrainsMono/master/install_manual.sh)"

echo "JetBrains Mono font installation complete!"