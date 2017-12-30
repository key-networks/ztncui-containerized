FROM centos:7
LABEL Description="This image is used to install Zerotier One and ztncui" Comment="Based on script from https://install.zerotier.com" Vendor="Key Networks (https://key-networks.com)" Version="1.0"

COPY build_zt1.sh /usr/bin/
RUN build_zt1.sh
EXPOSE 9993/udp

COPY build_ztncui.sh /usr/bin/
COPY openssl.cnf /tmp
RUN build_ztncui.sh
COPY .env /home/ztncui
EXPOSE 3443

COPY exec.sh /usr/sbin/

ENTRYPOINT ["/usr/sbin/exec.sh"]
