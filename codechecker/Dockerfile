FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive

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
        cmake \
        ninja-build \
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

# Dependencies for Postgres
RUN apt-get update\ 
    && sudo apt-get -y install \
    libpq-dev \
    python-psycopg2 \
    postgresql-common \
    python-pip \
    postgresql-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && sudo apt-get -y install \
        clang \
        clang-tidy \
        curl \
        doxygen \
        gcc-multilib \
        git \
        python-virtualenv\
        python-dev \
        thrift-compiler \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY ["init.sh", "entrypoint.sh", "wait-for-it/wait-for-it.sh", "/"]
RUN mkdir /src && chown casper:casper /src

###The above should not change too often.
# below is the more lightweight stuff that can change more often

USER casper

WORKDIR /home/casper/

RUN echo "export PATH=$PATH:/home/casper/codechecker/build/CodeChecker/bin" >> /home/casper/.bashrc \
    && echo ". /home/casper/codechecker/venv/bin/activate" >> /home/casper/.bashrc \
    && cd /home/casper/

RUN git clone https://github.com/Ericsson/codechecker.git --depth 1 codechecker \
    && cd codechecker \
    && make venv \
    && . $PWD/venv/bin/activate \
    && pip install psycopg2==2.8.1 \
    && make package

# We use this to connect to the postgres db
RUN echo "*:5432:*:codechecker:codechecker" >> ~/.pgpass && \
    chmod 0600 ~/.pgpass

RUN mkdir /home/casper/.codechecker \
    && touch /home/casper/.codechecker/root.user

CMD nohup /init.sh & sleep infinity

ENTRYPOINT ["/entrypoint.sh"]
