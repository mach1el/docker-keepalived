# Docker keepalived
Keepalived on docker

## Prerequisites
In order for this example to work, you need to enable binding to a non-local IP address. On each node run to enable this setting:

```
 $ echo 1 > /proc/sys/net/ipv4/ip_nonlocal_bind
```
To permanently save this setting, add the following line to a file like **/etc/sysctl.d/99-non-local-bind.conf**

```
net.ipv4.ip_nonlocal_bind = 1
```

## Master Node
```
docker run -tid \
--net=host \
--name=keepalived \
--restar=alawys \
--cap-add NET_ADMIN \
-e KEEPALIVED_AUTOCONF=true \
-e KEEPALIVED_STATE=MASTER \
-e KEEPALIVED_INTERFACE=eth0 \
-e KEEPALIVED_VIRTUAL_ROUTER_ID=51 \
-e KEEPALIVED_UNICAST_SRC_IP=10.10.0.21 \
-e KEEPALIVED_UNICAST_PEER_0=10.10.0.22 \
-e KEEPALIVED_TRACK_INTERFACE=eth0 \
-e KEEPALIVED_VIRTUAL_IPADDRESS_1="10.10.0.253/24 dev eth0" \
mich43l/keepalived
```
## Backup Node
```
docker run -tid \
--net=host \
--name=keepalived \
--restar=alawys \
--cap-add NET_ADMIN \
-e KEEPALIVED_AUTOCONF=true \
-e KEEPALIVED_STATE=BACKUP \
-e KEEPALIVED_INTERFACE=eth0 \
-e KEEPALIVED_VIRTUAL_ROUTER_ID=51 \
-e KEEPALIVED_UNICAST_SRC_IP=10.10.0.22 \
-e KEEPALIVED_UNICAST_PEER_0=10.10.0.21 \
-e KEEPALIVED_TRACK_INTERFACE=eth0 \
-e KEEPALIVED_VIRTUAL_IPADDRESS_1="10.10.0.253/24 dev eth0" \
mich43l/keepalived
```