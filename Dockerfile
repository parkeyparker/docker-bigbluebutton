FROM ubuntu:10.04
MAINTAINER James Yale jim@thebiggame.org

RUN apt-get -y update
RUN apt-get install -y language-pack-en vim wget curl
RUN update-locale LANG=en_US.UTF-8
RUN dpkg-reconfigure locales

# Add the BigBlueButton key
RUN wget http://ubuntu.bigbluebutton.org/bigbluebutton.asc -O- | apt-key add -

# Add the BigBlueButton repository URL and ensure the multiverse is enabled
RUN echo "deb http://ubuntu.bigbluebutton.org/lucid_dev_081/ bigbluebutton-lucid main" | tee /etc/apt/sources.list.d/bigbluebutton.list

#Add multiverse repo
RUN echo "deb http://archive.ubuntu.com/ubuntu/ lucid multiverse" | tee -a /etc/apt/sources.list
RUN apt-get -y update && apt-get -y dist-upgrade && apt-get -y clean

#Install LibreOffice
RUN wget http://bigbluebutton.googlecode.com/files/openoffice.org_1.0.4_all.deb && dpkg -i openoffice.org_1.0.4_all.deb && apt-get install -y python-software-properties && apt-add-repository ppa:libreoffice/libreoffice-4-0 && apt-get -y update && apt-get install -y libreoffice-common libreoffice && apt-get -y clean

#Install required Ruby version
RUN apt-get install -y libffi5 libreadline5 libyaml-0-2
RUN wget https://bigbluebutton.googlecode.com/files/ruby1.9.2_1.9.2-p290-1_amd64.deb && dpkg -i ruby1.9.2_1.9.2-p290-1_amd64.deb
RUN update-alternatives --install /usr/bin/ruby ruby /usr/bin/ruby1.9.2 500 \
                         --slave /usr/bin/ri ri /usr/bin/ri1.9.2 \
                         --slave /usr/bin/irb irb /usr/bin/irb1.9.2 \
                         --slave /usr/bin/erb erb /usr/bin/erb1.9.2 \
                         --slave /usr/bin/rdoc rdoc /usr/bin/rdoc1.9.2
RUN update-alternatives --install /usr/bin/gem gem /usr/bin/gem1.9.2 500

#Install ffmpeg
RUN apt-get install -y build-essential git-core checkinstall yasm texi2html libvorbis-dev libx11-dev libxfixes-dev zlib1g-dev pkg-config && apt-get -y clean
COPY deb/ffmpeg_5:2.0.1-1_amd64.deb .
RUN dpkg -i ffmpeg_5:2.0.1-1_amd64.deb

#Install Tomcat prior to bbb installation
RUN apt-get install -y tomcat6 && apt-get -y clean

#Replace init script, installed one is broken
COPY scripts/tomcat6 /etc/init.d/

#Install BigBlueButton
RUN su - -c "apt-get install -y bigbluebutton && apt-get -y clean" 

EXPOSE 80 9123 1935

#Add helper script to start bbb
COPY scripts/bbb-start.sh /usr/bin/

CMD ["/usr/bin/bbb-start.sh"]
