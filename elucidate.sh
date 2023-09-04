#!/bin/sh
# © 2020 Aman Verma <https://aman.raoverma.com/contact.html>
# Distributed under the 0-clause BSD license, see LICENSE.md file for details.

set -e
info_path="$HOME/Documents/projects/elucidate"

topics() {
    ls -1 "$info_path" | sed 's/[.]md$//'
}

usage() {
    progname="${0##*/}"
    printf 'Usage: %s [-eht] <topic>\n\n' "$progname"
    printf 'Topics:'
    # we want topics to split on words so we don't use quotes.
    printf ' %s' $(topics) | fold -sw 70 | sed -e 's/ $//' -e '2,$s/^/        /'
    printf '\n\n'
    printf '  -e  edit topics with editor\n'
    printf '  -h  show help\n'
    printf '  -t  print newline-separated list of topics, useful for completion scripts\n'
}

while getopts hte opt; do
    case $opt in
    h)
        usage
        exit 0
        ;;
    t)
        topics
        exit 0
        ;;
    e)
        "$VISUAL" "$info_path"
        exit $?
        ;;
    *)
        printf 'Use -h for help\n' >&2
        exit 1
        ;;
    esac
done
shift $((OPTIND - 1))

if [ -z "$1" ]; then
    printf 'No topic given.\n' >&2
    exit 1
fi

sed 's/^/  /' ~/.config/elucidate/"$1".md | less -F
