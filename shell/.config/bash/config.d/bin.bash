if [[ -d "$HOME/bin" ]]; then
	export PATH=$HOME/bin:$PATH
fi

if [[ -d "$HOME/.yarn/bin" ]]; then
	export PATH=$HOME/.yarn/bin:$PATH
fi