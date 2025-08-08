#!/bin/bash
#######################
## Autor: Edson Mota ##
## 20/10/2019 #########
## S.O Ubuntu 18.04 ###
#######################
  remvlan  
  s=`ifconfig -a | sed 's/[ \t].*//;/^$/d' |paste -s`
 for i in $s
 do
   echo "REMOVENDO VLANS" $s
   killall -9 dhclient &>/dev/null
   vconfig rem $i &>/dev/null
 done
 echo $getvlan
 echo "DIGITE A VLAN!:"
    read vlan

if [ $vlan = "1" ];
 then
     vconfig add eth0 $vlan
     ifconfig eth0.1 10.0.8.200/8
elif [ $vlan = "23" ];
 then
     vconfig add eth0 $vlan
     ifconfig eth0.23 192.168.2.138/24
     route add default gw 192.168.2.23
     echo "search redeinterna" > /etc/resolv.conf
     echo "nameserver 192.168.2.1" >> /etc/resolv.conf
     echo "nameserver 192.168.2.12" >> /etc/resolv.conf
     echo "nameserver 8.8.8.8" >> /etc/resolv.conf
	else
   echo "REINICIANDO DHCP CLIENTE."
   killall -9 dhclient &>/dev/null

 echo "INCUINDO A VLAN $vlan NA ETH"
    vconfig add eth0 $vlan
   dhclient eth0.$vlan

fi