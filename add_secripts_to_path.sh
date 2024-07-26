#!/bin/bash

# Get the current directory
current_dir=$(pwd)

# Add the current directory to PATH in ~/.bashrc if not already present
if ! grep -q "export PATH=\$PATH:$current_dir" ~/.bashrc; then
  echo "export PATH=\$PATH:$current_dir" >> ~/.bashrc
  echo "Added $current_dir to PATH in ~/.bashrc"
else
  echo "$current_dir is already in PATH"
fi

# Reload ~/.bashrc to apply changes
source ~/.bashrc

echo "Current PATH: $PATH"

