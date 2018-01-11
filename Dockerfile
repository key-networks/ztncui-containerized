FROM centos:7
LABEL Description="This image is used to install Zerotier One and ztncui" Vendor="Key Networks (https://key-networks.com)" Version="1.0"

COPY build.sh /usr/bin/
RUN build.sh
EXPOSE 9993/udp
EXPOSE 3443

COPY .env /opt/key-networks/ztncui

COPY exec.sh /usr/sbin/

ENTRYPOINT ["/usr/sbin/exec.sh"]
