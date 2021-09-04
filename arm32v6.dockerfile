# Copyright (c) 2021 fkmatsuda <fabio@fkmatsuda.dev>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of
# this software and associated documentation files (the "Software"), to deal in
# the Software without restriction, including without limitation the rights to
# use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
# FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
FROM alpine AS builder

# Download QEMU, see https://github.com/docker/hub-feedback/issues/1261
ENV QEMU_URL https://github.com/balena-io/qemu/releases/download/v3.0.0%2Bresin/qemu-3.0.0+resin-arm.tar.gz
RUN apk add curl && curl -L ${QEMU_URL} | tar zxvf - -C . --strip-components 1

FROM arm32v6/debian:stable-slim
COPY --from=builder qemu-arm-static /usr/bin

ENV ZULU_TAR=zulu11.50.19-ca-jdk11.0.12-linux_aarch32sf
ENV DOWNLOAD_URL=https://cdn.azul.com/zulu-embedded/bin/${ZULU_TAR}.tar.gz
ENV MAVEN_TAR=apache-maven-3.8.2

COPY scripts/install.sh ./

RUN ./install.sh

ENV MAVEN_HOME="/opt/maven/$MAVEN_TAR"
ENV JAVA_HOME="/opt/jdk/zulu11"
ENV PATH="$JAVA_HOME/bin:$PATH:$MAVEN_HOME/bin"
