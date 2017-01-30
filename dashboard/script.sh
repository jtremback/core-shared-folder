#! bash

# DEFAULT_VIA=$(ip route | awk -F\  '/default/ {print $3}')

DEFAULT_VIA=$(ip route | awk -F\  '
  /default/ {print $3}
')

ETH0_DEVICES=$(ip route | awk '
{
    /default/
    arr[$1] = $0
}

END {
    for (x = 1; x <= max; x++)
        print x
        print arr[x]
}
')

echo "$ETH0_DEVICES"