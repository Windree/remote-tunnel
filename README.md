# remote-tunnel
Remote tunnel to access ssh sever behind NAT using client public address

# Requres
socat

## Instalation
### Run on ssh server:
```
./tunnel.sh [local app port] [remote address] [port] 
```
[local app port] - ssh server port. 22 for ssh server.

[remote address] - public ssh client address

[port] - public ssh client port. You can use any unassigned port.



### Run on client side on [remote address]:
```
./tunnel-server.sh [port] [local port]
```
[port] - public ssh client port. You can use any unassigned port

[local port] - port to connect to ssh server. 2222 for example

