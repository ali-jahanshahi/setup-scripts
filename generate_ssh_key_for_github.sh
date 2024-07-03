#!/bin/bash

# Prompt for the GitHub username
read -p "Enter your GitHub username: " GITHUB_USERNAME

# Prompt for the key name
read -p "Enter the name for your SSH key (e.g., id_ed25519_github): " KEY_NAME

# Check if the GitHub username or key name was not provided
if [ -z "$GITHUB_USERNAME" ] || [ -z "$KEY_NAME" ]; then
  echo "Usage: Please provide both the GitHub username and the SSH key name."
  echo "Example: ./generate_ssh_key_for_github.sh"
  echo "Follow the prompts to enter your GitHub username and the SSH key name."
  exit 1
fi

# Set the key path
KEY_PATH="$HOME/.ssh/$KEY_NAME"

# Generate the SSH key
ssh-keygen -t ed25519 -f "$KEY_PATH" -N ""

# Check if SSH config file exists, if not create it
SSH_CONFIG="$HOME/.ssh/config"
if [ ! -f "$SSH_CONFIG" ]; then
  touch "$SSH_CONFIG"
fi

# Append configuration for the generated SSH key
echo -e "\nHost github.com" >> "$SSH_CONFIG"
echo "    HostName github.com" >> "$SSH_CONFIG"
echo "    User git" >> "$SSH_CONFIG"
echo "    IdentityFile $KEY_PATH" >> "$SSH_CONFIG"

# Set correct permissions for SSH config file
chmod 600 "$SSH_CONFIG"

# Print the public key
if [ -f "$KEY_PATH.pub" ]; then
  echo "Public key:"
  cat "$KEY_PATH.pub"
else
  echo "Error: Public key file not found."
  exit 1
fi

# Print instructions for adding the key to GitHub
echo -e "\nTo add the SSH key to your GitHub account, follow these steps:"
echo "1. Copy the public key above."
echo "2. Go to https://github.com/settings/keys"
echo "3. Click 'New SSH key', provide a title, and paste the key."


