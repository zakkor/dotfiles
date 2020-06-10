#PLAN9="$(dirname $(dirname $(readlink $(which 9))))/plan9"
PLAN9=/nix/store/95anarn3qmi373x0s60r9j0zwzn7dv7f-plan9port-2019-02-25/plan9

if [ $TERM = "dumb" ]; then

if [ "$(pgrep plumber)" ]; then
	9 plumber
fi

cat "$PLAN9/plumb/basic" ~/.acme/plumbing | 9 write plumb/rules

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
