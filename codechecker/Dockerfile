FROM ubuntu:18.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get -y install \
        sudo \
        git \
        wget \
        curl \
        autoconf \
        automake \
        pkg-config \
        libevent-dev \
        libncurses5-dev \
        build-essential \
        libtool \
        vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER root
RUN useradd -ms /bin/bash casper \
    && echo casper:work | chpasswd \
    && adduser casper sudo

RUN apt-get update \
    && sudo apt-get -y install \
        clang \
        clang-tidy \
        build-essential \
        curl \
        doxygen \
        gcc-multilib \
        git \
        python-virtualenv\
        python-dev \
        thrift-compiler \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

###The above should not change too often.
# below is the more lightweight stuff that can change more often

WORKDIR /home/casper/

RUN echo "export PATH=$PATH:/home/casper/codechecker/build/CodeChecker/bin" >> /home/casper/.bashrc \
    && cd /home/casper/

RUN git clone https://github.com/Ericsson/codechecker.git --depth 1 codechecker \
    && cd codechecker \
    && make venv \
    && . $PWD/venv/bin/activate \
    && make package

# We use this to connect to the postgres db
RUN echo "*:5432:*:codechecker:codechecker" >> ~/.pgpass && \
    chmod 0600 ~/.pgpass

USER casper
CMD /bin/bash

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
