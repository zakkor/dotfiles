#!/bin/sh

# Destination dir overrides:
# The dir name's value in this map will be used as the stow --target arg
# Example: ["nix"]="/etc/nixos/" => stow --target "/etc/nixos/" nix
declare -A destinations
destinations=(
  ["nixos"]="/etc/nixos/"
)

# Check if stow is installed
stow --version > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "stow is not installed"
  exit 1
fi

for dir in */ ; do
  dest="${destinations[${dir%/}]}"
  if [ -z "$dest" ]; then
    stow -v "$dir"
  else
    stow -v -t "$dest" "$dir"
  fi
done