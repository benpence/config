#!/bin/sh

mv /etc/resolv.conf /etc/resolv.conf.bak

echo "search ec2.internal" > /etc/resolv.conf
echo "nameserver 172.16.0.23" >> /etc/resolv.conf
