#!/bin/sh

if [ -z $1 ]; then
  echo "specify machine name as first argument (options: $(cd nixos/machines; echo *))"
  exit 1
fi

ln -s "`pwd`/nixos/machines/$1/default.nix" /etc/nixos/configuration.nix
