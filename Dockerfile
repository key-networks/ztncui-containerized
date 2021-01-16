FROM centos:8
LABEL Description="ztncui (a ZeroTier network controller user interface) + Zerotier One" Vendor="Key Networks (https://key-networks.com)"
ADD VERSION .

COPY build.sh /usr/bin/
RUN build.sh

EXPOSE 8000/tcp
EXPOSE 3443/tcp

COPY exec.sh /usr/sbin/
ENTRYPOINT ["/usr/sbin/exec.sh"]
