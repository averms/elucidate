#!/bin/sh
# elucidate - a personal documentation tool. I use it to refresh my memory
# about occasionally used programs like wget and sed.
#
# Requires a POSIX-conforming environment.
#
# Distributed under the 0-clause BSD license.
set -e
info_path="$HOME/.config/elucidate"

topics() {
    ls -1 "$info_path" | sed -e 's/\.md$//'
}

usage() {
    local progname="${0##*/}"
    printf 'Usage:\n'
    printf '  %s <topic>\n' "$progname"
    printf '  %s -e|-h|-t\n' "$progname"
    # TODO: document options.
    printf 'Topics:\n'
    # we want topics_list to split on words so we don't use quotes.
    printf '  %s\n' $topics_list
}

topics_list="$(topics)"

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
        "$EDITOR" "$info_path"
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
