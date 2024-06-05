FROM rockylinux:9

#RUN dnf install -y net-tools tcpdump iptables lsof bind-utils dnsmasq vim git nmap iputils iproute

RUN dnf install -y iptables iproute

ADD ./bin /opt/pocketsoc-ng/bin

RUN chmod +x /opt/pocketsoc-ng/bin/startup.sh

CMD ["/opt/pocketsoc-ng/bin/startup.sh"]
