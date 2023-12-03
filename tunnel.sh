#!/bin/env bash
set -Eeuxo pipefail

help=
local_port=
remote_address=
remote_port=

while [ $# -gt 0 ]; do
    case "$1" in
    -h | --help)
        help=1
        ;;
    -l | --local-port)
        local_port="${2:-}"
        ;;
    -r | --remote)
        remote_address="${2:-}"
        ;;
    -p | --port)
        remote_port="${2:-}"
        ;;
    *)
        echo "Invalid argument '$1'"
        exit 1
        ;;
    esac
    shift
    [[ $# -gt 0 ]] && shift
done

function main() {
    while [ : ]; do
        socat -d -d tcp:$remote_address:$remote_port,forever,intervall=1,fork,reuseaddr tcp:localhost:$local_port
    done
}

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

    if ! which socat 2>&1 >/dev/null; then
        echo "Socat not found. Install socat."
        error=1
    fi

    if [ $error -ne 0 ]; then
        exit 1
    fi
}

function print_help() {
   cat <<'EOF'
./tunnel.sh -l|--local-port [local app port] -r|--remote [remote address] -p|--port [port] 

[local app port] - local app port. 22 for ssh server.
[remote address] - public client address
[port] - public client port. You can use any unassigned port.
EOF
}

if [ ! -z ${help:-} ]; then
    print_help
    exit 0
fi

validate_arguments
main
