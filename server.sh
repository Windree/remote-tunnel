#!/bin/env bash
set -Eeuo pipefail

unset -v help
unset -v local_port
unset -v port

while [ $# -gt 0 ]; do
    case "$1" in
    -h | --help)
        help=1
        ;;
    -l | --local-port)
        local_port="${2:-}"
        ;;
    -p | --port)
        port="${2:-}"
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
    socat -d tcp-l:$local_port,reuseaddr,fork tcp-l:$port,reuseaddr
}

function validate_arguments() {
    local error=0
    if [ ! -v port ] || [ -z $port ]; then
        echo "Server port parameter required."
        error=1
    fi

    if [ ! -v local_port ] || [ -z $local_port ]; then
        echo "Local listener port parameter required."
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
./server.sh -h|--help | (-l|--local-port [local listener port] -p|--port [port])

-h --help - show a help
-l --local-port [local listener port] - local app port.
-p --port [port] - server port. You can use any unassigned port.
EOF
}

if [ -v help ]; then
    print_help
    exit 0
fi

validate_arguments
main
