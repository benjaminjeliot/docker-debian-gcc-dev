FROM debian:bullseye

LABEL maintainer="benjaminjeliot@gmail.com"

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    gcc \
    g++ \
    gfortran \
    make \
    ca-certificates \
    wget \
    cmake \
    gcovr \
    cppcheck \
    python3 \
    python3-pip \
    python3-pytest \
    googletest \
 && rm -rf /var/lib/apt/lists/*

# Install cpplint
RUN pip3 install cpplint

# Build and install Google Test
RUN mkdir gtest-build \
 && cd gtest-build \
 && export CXX=g++ CC=gcc \
 && cmake \
    -DBUILD_GTEST:BOOL=ON \
    -DCMAKE_INSTALL_PREFIX:PATH=/usr/local \
    /usr/src/googletest \
 && cmake --build . \
 && cmake --build . --target install \
 && cd .. \
 && rm -rf gtest-build
