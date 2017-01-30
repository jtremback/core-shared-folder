# usage: setup.sh <my peer number> <their peer number>

a=$1

shift
for var in "$@"
do
    ip link add wg$var type wireguard

    wg set wg$var \
    listen-port 2345 \
    private-key /home/jehan2/host/wg-test/privatekey$a \
    peer $(cat /home/jehan2/host/wg-test/publickey$var) \
    allowed-ips 0.0.0.0/0 \
    endpoint 10.0.0.$var:2345

    ip link set up dev wg$var
    # ip addr add dev wg$var 10.0.1.$a$var
    # ip route add 10.0.0.$var dev eth0
    # ip route add 10.0.1.$var$a dev wg$var
done