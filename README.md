# ztncui-containerized
## ZeroTier network controller user interface in a Docker container

This is a Docker image that contains **[ZeroTier One](https://www.zerotier.com/download.shtml)** and **[ztncui](https://key-networks.com/ztncui)** to set up a **standalone ZeroTier network controller** with a web user interface in a container.

Follow us on [![alt @key_networks on Twitter](https://i.imgur.com/wWzX9uB.png)](https://twitter.com/key_networks)

## Docker run
```shell
docker run -dp 3443:3443 --cap-add=NET_ADMIN keynetworks/ztncui
```
See below for a more secure way of running the container.

## Connect to the user interface
Open a web browser to `https://docker_host:3443` where docker_host is the hostname or IP address of the machine running the container.

## Password
The default username is **admin** and default password is **password**.  It would be best practice to restrict access to port 3443 of docker_host to the IP address of your machine before running the container, so that nobody else can login before you do.  You can do this as follows:

First assign your IP address to an environment variable, for example:
```shell
MYADDR=12.34.56.78
```
This is to allow you to execute the following two commands in one shot to minimise the chance of some nefarious character getting in before you do:
```shell
docker run --name ztncui -dp 3443:3443 --cap-add=NET_ADMIN keynetworks/ztncui && \
docker exec ztncui iptables -I INPUT -i eth0+ ! -s $MYADDR -p tcp --dport 3443 -j DROP
```

## Persist Data in volumes
If you want to persist the ZeroTier and ztncui data in volumes outside of the container, then use this approach:

First assign your IP address to an environment variable, for example:
```shell
MYADDR=12.34.56.78
```
Then, execute in one shot:
```shell
docker run -dp 3443:3443 --name ztncui --volume ztncui:/opt/key-networks/ztncui/etc/ \
--volume zt1:/var/lib/zerotier-one/ --cap-add=NET_ADMIN keynetworks/ztncui && \
docker exec ztncui iptables -I INPUT -i eth0+ ! -s $MYADDR -p tcp --dport 3443 -j DROP
```

## Copy volumes to another Docker host
For various reasons (controller backup, redundancy, etc), it is useful to be able to copy the zt1 and ztncui volumes from one Docker host to another.
To copy the volumes from host1 to host2, first stop the ztncui container on host1:
```shell
docker stop ztncui
```
To copy the ztncui volume from host1 to host2, execute the following on host1:
```shell
docker run --rm --volume ztncui:/from alpine ash -c "cd /from ; tar -cf - . " | ssh user@host2 'docker run --rm -i --volume ztncui:/to alpine ash -c "cd /to ; tar -xpvf - " '
```
To copy the zt1 volume from host1 to host2, execute the following on host1:
```shell
docker run --rm --volume zt1:/from alpine ash -c "cd /from ; tar -cf - . " | ssh user@host2 'docker run --rm -i --volume zt1:/to alpine ash -c "cd /to ; tar -xpvf - " '
```
To run the container on host2:
```shell
docker run -dp 3443:3443 --name ztncui --volume ztncui:/opt/key-networks/ztncui/etc/ \
--volume zt1:/var/lib/zerotier-one/ --cap-add=NET_ADMIN keynetworks/ztncui
```

## Pass environment variables
As per https://github.com/key-networks/ztncui#summary-of-listening-states, environment variables can be passed with --env as of ztncui:1.2.2, for example:
```shell
docker run --env HTTP_PORT=8000 --env HTTPS_PORT=4443 --env HTTP_ALL_INTERFACES=yes -dp 4443:4443 -p 8000:8000 --name ztncui --cap-add=NET_ADMIN keynetworks/ztncui
```
Note that the above will expose both HTTP and HTTPS publicly... probably not something you want to do.

## Screenshots
Screenshots can be found at https://key-networks.com/ztncui#screenshots

## Usage
Usage is describe in `README.md` displayed at https://github.com/key-networks/ztncui

## Source Code
The source code for ztncui is at https://github.com/key-networks/ztncui

The source code for the docker image is in this repository.

## Feedback
Please give us your feedback.  Please use the contact form at [key-networks.com](https://key-networks.com/).

## Bug and Vulnerability Reporting
Problems can be reported using the GitHub issue tracking system.  Please use the contact form at [key-networks.com](https://key-networks.com/) to privately report potential vulnerabilities.  Thank you.

## License
This is open source code, licensed under the GNU GPLv3, and is free to use on those terms. If you are interested in commercial licensing, please contact us via the contact form at [key-networks.com](https://key-networks.com) .

## Thanks
@flantel for contributing "Update exec.sh to allow override of HTTP_ variables from environment".

https://www.guidodiepen.nl/2016/05/transfer-docker-data-volume-to-another-host/ for command line for copying Docker volumes between machines.
