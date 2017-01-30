# usage: addrules <peer_number> ...

nft flush ruleset
nft add table althea
nft add chain althea fwd "{ type filter hook forward priority 0; policy drop; }"

for iif in "$@"
do
  for oif in "$@"
  do
    if [ $iif != $oif ]; then
      nft add rule althea fwd meta iifname "peer$iif" oifname "peer$oif" mark set $iif$oif accept
    fi
  done
done

nft list ruleset -a