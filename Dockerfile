FROM centos:7
LABEL Description="This image is used to install Zerotier One and ztncui" Comment="build_zt1.sh is based on the script from https://install.zerotier.com" Vendor="Key Networks (https://key-networks.com)" Version="1.0"

COPY build_zt1.sh /usr/bin/
RUN build_zt1.sh
EXPOSE 9993/udp

RUN yum install https://download.key-networks.com/el7/ztncui/1/ztncui-release-1-1.noarch.rpm -y
RUN yum install ztncui -y
RUN yum install sudo -y
RUN rm -f /var/lib/zerotier-one/authtoken.secret

COPY .env /opt/key-networks/ztncui
EXPOSE 3443

COPY exec.sh /usr/sbin/

ENTRYPOINT ["/usr/sbin/exec.sh"]
