FROM rockylinux:9

COPY ./repo/zeek.repo /etc/yum.repos.d/

RUN dnf install ethtool epel-release wget -y 

#RUN dnf install -y cmake make gcc gcc-c++ flex bison libpcap-devel openssl-devel python3 python3-devel swig zlib-devel git

RUN wget https://repo.almalinux.org/development/almalinux/9/devel/noarch/Packages/python3-semantic_version-2.8.4-7.el9.noarch.rpm
RUN dnf localinstall -y python3-semantic_version-2.8.4-7.el9.noarch.rpm
RUN dnf config-manager --set-enabled crb
RUN dnf clean all

RUN dnf install -y zeek tcpdump supervisor tcpreplay && dnf update -y && \ 
    dnf clean all && rm -rf /var/cache/dnf

#RUN git clone --recursive https://github.com/zeek/zeek && cd ./zeek && ./configure --prefix="/opt/zeek" && make && make install

RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch 
COPY ./repo/elastic-oss.repo /etc/yum.repos.d/

RUN dnf install -y filebeat

env PATH /opt/zeek/bin/:$PATH

ADD ./config/zeekctl.cfg /opt/zeek/etc/zeekctl.cfg
ADD ./config/networks.cfg /opt/zeek/etc/networks.cfg
ADD ./config/node.cfg /opt/zeek/etc/node.cfg

COPY ./config/local.zeek /opt/zeek/share/zeek/site/local.zeek
COPY ./config/mattermost.zeek /opt/zeek/share/zeek/site/mattermost.zeek

COPY ./config/filebeat.yml /etc/filebeat/filebeat.yml

ADD ./bin /opt/pocketsoc-ng/bin
RUN chmod +x /opt/pocketsoc-ng/bin/startup.sh

ADD ./config/supervisor.conf /etc/supervisord.conf
CMD ["/opt/pocketsoc-ng/bin/startup.sh"]
