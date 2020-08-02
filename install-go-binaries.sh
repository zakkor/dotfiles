#!/usr/bin/env bash

mkdir -p $HOME/bin

for pkg in \
	9fans.net/go/acme/Watch \
	9fans.net/go/acme/acmego \
	github.com/zakkor/arefresh \
	golang.org/x/tools/gopls \
	github.com/fhs/acme-lsp/cmd/acme-lsp \
	github.com/fhs/acme-lsp/cmd/L \
	github.com/rogpeppe/godef; do
	echo "go get -u $pkg"
	go get -u $pkg

	base=$(basename $pkg)
	echo "cp $GOPATH/bin/$base $HOME/bin/$base"
	cp "$GOPATH/bin/$base" "$HOME/bin/$base"
done


