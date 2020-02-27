#!/bin/sh

if [ -z $1 ]; then
  echo "specify machine name as first argument (options: dinghy, mescal)"
  exit 1
fi

ln -s "`pwd`/nixos/machines/$1/default.nix" /etc/nixos/configuration.nix
