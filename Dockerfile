FROM centos:centos8.1.1911 as builder

ARG NINJA_VERSION=1.10.0

# install build dependencies
RUN yum -y install gcc-c++ make python2
RUN alternatives --set python /usr/bin/python2

# build Python from source
RUN pushd /home && \
    curl -o ninja.tar.gz -L https://github.com/ninja-build/ninja/archive/v${NINJA_VERSION}.tar.gz  && \
    tar xf ninja.tar.gz    && \
    mkdir build      && \
    pushd build && \
    ../ninja-${NINJA_VERSION}/configure.py --bootstrap

FROM centos:centos8.1.1911
COPY --from=builder /home/build/ninja /usr/local/bin/
