#!/usr/bin/env bash
set -e

function main() {
    if [[ $# -eq 0 ]]; then
        printf "\nbrownie loading...!\n"
        printf "\nbrownie --help \n"
    else
        printf "\nERROR %s!\n" "${1}"
    fi
}
main "$@"

/bin/bash