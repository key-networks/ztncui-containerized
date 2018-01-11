FROM centos:7
LABEL Description="This image contains Zerotier One and ztncui" Vendor="Key Networks (https://key-networks.com)" Version="1.0"

COPY build.sh exec.sh /usr/sbin/
RUN /usr/sbin/build.sh
EXPOSE 9993/udp
EXPOSE 3443

ENTRYPOINT ["/usr/sbin/exec.sh"]
