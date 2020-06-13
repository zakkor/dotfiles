#!/usr/bin/env bash

d="$1"
if [ $# -eq 0 ]; then
	d=$HOME/bin
fi

echo "cleaning symlinks in \"$d\""
find "$d" | xargs file | grep "broken symbolic link" | cut -d':' -f1 | xargs -L 1 unlink