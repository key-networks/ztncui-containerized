# ztncui-containerized
## ZeroTier network controller user interface in a Docker container

This is a Docker image that contains ZeroTier One and ztncui to set up a standalone ZeroTier network controller with a web user interface in a container.

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
