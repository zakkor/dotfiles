#!/usr/bin/env bash

othersink=$(pacmd list-sinks | egrep -o '[^*] index: ([0-9]+)' | cut -d' ' -f4)
sinkinput=$(pacmd list-sink-inputs | egrep -o 'index: ([0-9]+)' | cut -d' ' -f2)

pacmd set-default-sink "$othersink"
pacmd move-sink-input "$sinkinput" "$othersink"