BASH_CONFIG_PATH=$HOME/.config/bash
BASH_DATA_PATH=$HOME/.local/share/bash

mkdir -p $BASH_DATA_PATH

export PS1="\w \\$ "

# Load configuration
for conf in $BASH_CONFIG_PATH/config.d/*.bash; do
    source $conf
done

[ -f ~/.bashrc.local ] && source ~/.bashrc.local
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
