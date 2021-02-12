#!/usr/bin/env bash

sink=$(pacmd list-sinks | egrep -o '\* index: ([0-9]+)' | cut -d' ' -f3)

if [[ $sink -eq 0 ]]; then
  echo "Speakers"
elif [[ $sink -eq 1 ]]; then
  echo "Headphones"
fi