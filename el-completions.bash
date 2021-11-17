_el() {
    local IFS=$'\n'
    local suggestions="$("$1" -t)"
    COMPREPLY=($(compgen -W "$suggestions" -- "${COMP_WORDS[COMP_CWORD]}"))
} && complete -F _el el
