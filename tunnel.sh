#!/bin/env bash
set -Eeuxo pipefail

while [ $# -gt 0 ]; do
    case "$1" in
    -l | --local-port)
        local_port="$2"
        ;;
    -r | --remote)
        remote_address="$2"
        ;;
    -p | --port)
        remote_port="$2"
        ;;
    *)
        echo "Invalid argument '$1'"
        exit 1
        ;;
    esac
    shift
    shift
done

function validate_arguments() {
    local error=0
    if [ -z ${local_port+x} ]; then
        echo "Local port parameter required"
        error=1
    fi

    if [ -z ${remote_address+x} ]; then
        echo "Remote address parameter required"
        error=1
    fi

    if [ -z ${remote_port+x} ]; then
        echo "Remote port parameter required"
        error=1
    fi

    if ! which socat; then
        echo "Socat not found. install socat."
        error=1
    fi

    if [ $error -ne 0 ]; then
        exit 1
    fi
}

function main() {
    while [ : ]; do
        socat -d -d tcp:$remote_address:$remote_port,forever,intervall=1,fork,reuseaddr tcp:localhost:$local_port
    done
}

validate_arguments
main