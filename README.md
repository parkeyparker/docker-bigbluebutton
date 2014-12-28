# docker-bigbluebutton

Unofficial BigBlueButton 0.81 docker image. This repository contains the Dockerfile and all other files needed to build the docker image. 

More info about BigBlueButton at: http://bigbluebutton.org/


### About this image and the Dockerfile:

This image is based on Ubuntu 10.04 x86_64, which is the [officially supported O.S](https://code.google.com/p/bigbluebutton/wiki/InstallationUbuntu#Before_You_Install). for BigBlueButton 0.81. The Dockerfile follows the [official installation instructions](https://code.google.com/p/bigbluebutton/wiki/InstallationUbuntu#Installing_BigBlueButton_0.81) found on BigblueButton's documentation, plus some fixes needed to successfully boot the container. 

You can find a prebuilt docker image from [Docker Hub](https://registry.hub.docker.com/u/juanluisbaptiste/bigbluebutton/). To be able to use it, first it has to be pulled off from the Hub:

    sudo docker pull khoiln/bigbluebutton:latest
  
And then you can run a container from it, see instructions below on how to do it.

This is still an **alpha version** use it at your own risk. There is still some stuff about how to handle the different services that conform the BigBlueButton app inside the docker container that I need to improve.

### To Init a Bigbluebutton container
    sudo docker run -d -p 9123:9123 -p 80:80 -p 1935:1935 --name bbb jamesyale/docker-bigbluebutton
### (optional) To Init a Bigbluebutton container with a known secret
    sudo docker run -d -p 9123:9123 -p 80:80 -p 1935:1935 -e secret=<bbbsecret> --name bbb jamesyale/docker-bigbluebutton
### (optional/recommended for production use) To Init a Bigbluebutton container with a known secret and external storage
    sudo docker run -d -p 9123:9123 -p 80:80 -p 1935:1935 -e secret=<bbbsecret> -v /path/to/some/storage /var/bigbluebutton --name bbb jamesyale/docker-bigbluebutton

### Start and Stop Bigbluebutton
From now on you could refer to Bigbluebutton container as "bbb"
You could do

    sudo docker start bbb
    sudo docker stop bbb
### Bigbluebutton SALT
    
    a1ab45a9fd1c21c6ac9314166d9dc3c9
