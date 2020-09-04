#!/bin/sh
# elucidate - a personal documentation tool. I use it to refresh my memory
# about occasionally used programs like wget and sed.
#
# Requires sharkdp's bat and a POSIX-compliant environment.
#
# Distributed under the 0-clause BSD license.
set -e

topics() {
    ls -1 ~/.config/elucidate | sed -e 's/\.md$//'
}

usage() {
    local progname="${0#*/}"
    printf 'Usage:\n'
    printf '        %s <topic>\n' "$progname"
    printf '        %s -h|-t\n' "$progname"
    printf 'Topics:\n'
    # topics_list can't have any spaces in filenames.
    printf '        %s\n' $topics_list
}

topics_list="$(topics)"

while getopts ht opt; do
    case "$opt" in
    h)
        usage
        exit 0
        ;;
    t)
        topics
        exit 0
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

bat ~/.config/elucidate/"$1".md
