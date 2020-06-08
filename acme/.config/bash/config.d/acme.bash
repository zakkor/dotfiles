if [ $TERM = "dumb" ]; then

export PS1="$PS1\n"
unalias ls

_cd () {
        \cd "$@" &&
        case "$TERM!$-" in
        linux!*)
                ;;
        *!*i*)
                awd
        esac
}
alias cd=_cd

mkdir -p ~/.acme/default
NAMESPACE="~/.acme/default"

fi
