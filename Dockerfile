FROM jrottenberg/ffmpeg:4.0-vaapi

RUN \
  apt-get update && \
  apt-get install -y \
  git \
  python-pip \
  openssl \
  python-dev \
  libffi-dev \
  libssl-dev \
  libxml2-dev \
  libxslt1-dev \
  zlib1g-dev

RUN \
  pip install --upgrade pip && \
  hash -r pip && \
  pip install requests && \
  pip install requests[security] && \
  pip install requests-cache && \
  pip install babelfish && \
  pip install 'guessit<2' && \
  pip install 'subliminal<2' && \
  pip install stevedore==1.19.1 && \
  pip install python-dateutil && \
  pip install qtfaststart



# Clone sickbeard_mp4_automator from GIT
RUN \
  git clone git://github.com/mdhiggins/sickbeard_mp4_automator.git /opt/mp4_automator && \
  touch /opt/mp4_automator/info.log
  

# Copy watcher script from GIT to mp4_automator folder
COPY mp4automator_watcher /opt/mp4_automator/mp4automator_watcher

RUN \
    chmod a+rwx -R /opt/mp4_automator
    
    
RUN \  
    rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*
  
# Make Symbolic Link for Config File & Workdirs  
RUN \  
  ln -s /downloads /data && \
  ln -s /config/autoProcessDefault.ini /opt/mp4_automator/autoProcess.ini

# Install inotofy for watcher script
RUN \
  apt-get update -y && \
  apt-get install inotify-tools -y

ENV SETTLE_DOWN_TIME 600
  

WORKDIR     /opt/mp4_automator

ENV DOCKER_DATA /config
ENV DOCKER_VOLUME /workdir
VOLUME ["$DOCKER_DATA", "$DOCKER_VOLUME"]

RUN /
   wget https://raw.githubusercontent.com/mdhiggins/sickbeard_mp4_automator/master/autoProcess.ini.sample -O opt/mp4_automator/autoProcessDefault.ini

ARG        PREFIX=

CMD         ['tail' '-f' '/dev/null']
# ENTRYPOINT ["/usr/bin/filebot-watcher"]
ENTRYPOINT [""]


