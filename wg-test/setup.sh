ip link add wg0 type wireguard
ip addr add dev wg0 10.0.1.$1

wg set wg0 \
listen-port 2345 \
private-key /home/jehan2/host/wg-test/privatekey$1 \

ip link set up dev wg0

shift
for var in "$@"
do
    ip route add 10.0.0.$var dev eth0

    wg set wg0 \
    peer $(< /home/jehan2/host/wg-test/publickey$var) \
    allowed-ips 10.0.1.$var \
    endpoint 10.0.0.$var:2345

    ip route add 10.0.1.$var dev wg0
done