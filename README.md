# remote-tunnel
Remote tunnel to access ssh sever behind NAT using client public address

# Requres
socat

## Instalation
### Run on ssh server:
```
./tunnel.sh -h|--help |(-l|--local-port [local app port] -r|--remote [remote address] -p|--port [port])
```

-h --help - show a help

-l --local-port [local app port] - local app port. 22 for ssh server.

-r --remote [remote address] - public client address

-p --port [port] - public client port. You can use any unassigned port.



### Run on client side on [remote address]:
```
./server.sh -h|--help |(-l|--local-port [local listener port] -p|--port [port])
```

-h --help - show a help

-l --local-port [local listener port] - local app port.

-p --port [port] - server port. You can use any unassigned port.

