# docker-bigbluebutton

Unofficial BigBlueButton 0.81 docker image. This repository contains the Dockerfile and all other files needed to build the docker image. 

More info about BigBlueButton at: http://bigbluebutton.org/

## Version
0.1 Tagged first docker registry release
0.2 Add option for setting hostname of bbb instance (bbb-conf --setip)

## About this image and the Dockerfile:

This image is based on Ubuntu 10.04 x86_64, which is the [officially supported O.S](https://code.google.com/p/bigbluebutton/wiki/InstallationUbuntu#Before_You_Install). for BigBlueButton 0.81. The Dockerfile follows the [official installation instructions](https://code.google.com/p/bigbluebutton/wiki/InstallationUbuntu#Installing_BigBlueButton_0.81) found on BigblueButton's documentation, plus some fixes needed to successfully boot the container. 

This image is based on the previous work by juanluisbaptiste / khoiln:

https://registry.hub.docker.com/u/juanluisbaptiste/bigbluebutton/
https://registry.hub.docker.com/u/khoiln/bigbluebutton/

## Start and Stop Bigbluebutton

### To Init a Bigbluebutton container
    sudo docker run -d -p 9123:9123 -p 80:80 -p 1935:1935 --name bbb jamesyale/docker-bigbluebutton
### (optional) To Init a Bigbluebutton container with a known secret
    sudo docker run -d -p 9123:9123 -p 80:80 -p 1935:1935 -e secret=<bbbsecret> --name bbb jamesyale/docker-bigbluebutton
### (optional/recommended for production use) To Init a Bigbluebutton container with a known secret, hostname and external storage
    sudo docker run -d -p 9123:9123 -p 80:80 -p 1935:1935 -e secret=<bbbsecret> -e host=<hostname/IP> -v /path/to/some/storage /var/bigbluebutton --name bbb jamesyale/docker-bigbluebutton

From now on you could refer to Bigbluebutton container as "bbb"
You could do

    sudo docker start bbb
    sudo docker stop bbb
