FROM ubuntu:16.04

# bootstrap environment
ENV DEPS_HOME="/root/janus"
ENV SCRIPTS_PATH="/tmp/scripts"

# install baseline package dependencies
RUN apt-get -y update && apt-get install -y libmicrohttpd-dev \
  libjansson-dev \
  libcurl4-openssl-dev \
  libnice-dev \
  libssl-dev \
  libsrtp-dev \
  libsofia-sip-ua-dev \
  libglib2.0-dev \
  libopus-dev \
  libogg-dev \
  libini-config-dev \
  libcollection-dev \
  pkg-config \
  gengetopt \
  libtool \
  automake \
  build-essential \
  subversion \
  git \
  cmake \
  wget \
  npm \
  nano \
  libwebsockets-dev \
  libsrtp-dev

ADD scripts/bootstrap.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/bootstrap.sh

ADD scripts/usrsctp.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/usrsctp.sh

ENV JANUS_RELEASE="v0.1.2"
ADD scripts/janus.sh $SCRIPTS_PATH/
RUN $SCRIPTS_PATH/janus.sh

RUN touch /var/log/meetecho

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY run.sh /run.sh
RUN chmod a+rx /run.sh

EXPOSE 10000-10200/udp
EXPOSE 8088
EXPOSE 8089
EXPOSE 8889
EXPOSE 8000
EXPOSE 7088
EXPOSE 7089
EXPOSE 8188
EXPOSE 8989

ENTRYPOINT ["/run.sh"]
