FROM ubuntu:14.04
MAINTAINER Aaron Parker aaron@sourcecube.co.uk

RUN apt-get -y update
RUN apt-get install -y language-pack-en vim wget curl
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

# Add the BigBlueButton key
RUN wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | apt-key add -

# Add the BigBlueButton repository URL and ensure the multiverse is enabled
RUN echo "deb http://ubuntu.bigbluebutton.org/trusty-090/ bigbluebutton-trusty main" | tee /etc/apt/sources.list.d/bigbluebutton.list

#Add multiverse repo
RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty multiverse" | tee -a /etc/apt/sources.list
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y clean

#Install LibreOffice
#RUN wget http://bigbluebutton.googlecode.com/files/openoffice.org_1.0.4_all.deb && dpkg -i openoffice.org_1.0.4_all.deb && apt-get install -y python-software-properties && apt-add-repository ppa:libreoffice/libreoffice-4-0 && apt-get -y update && apt-get install -y libreoffice-common libreoffice && apt-get -y clean
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:libreoffice/libreoffice-4-4

#Install ffmpeg
RUN apt-get install -y build-essential git-core checkinstall yasm texi2html libvorbis-dev libx11-dev libvpx-dev libxfixes-dev zlib1g-dev pkg-config netcat libncurses5-dev && apt-get -y clean
#COPY deb/ffmpeg_5:2.0.1-1_amd64.deb .
#RUN dpkg -i ffmpeg_5:2.0.1-1_amd64.deb
COPY scripts/install-ffmpeg.sh /tmp/install-ffmpeg.sh
RUN chmod +x /tmp/install-ffmpeg.sh \
&& /bin/bash -c /tmp/install-ffmpeg.sh

#Install BigBlueButton
RUN apt-get install -y bigbluebutton && apt-get -y clean
RUN apt-get install -y bbb-check
RUN bbb-conf --enablewebrtc

EXPOSE 80 9123 1935

#Add helper script to start bbb
COPY scripts/bbb-start.sh /usr/bin/

CMD ["/usr/bin/bbb-start.sh"]
