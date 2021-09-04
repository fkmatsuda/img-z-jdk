#!/bin/bash

apt-get update -qq && apt-get upgrade -qq --autoremove --purge
apt-get install -qq wget git java-common libasound2 libxi6 libxtst6 nodejs npm
apt-get clean
mkdir -p /opt/maven /opt/jdk
wget $DOWNLOAD_URL
tar -C /opt/jdk -xzf ./$ZULU_TAR.tar.gz
mv /opt/jdk/$ZULU_TAR /opt/jdk/zulu11
rm ./$ZULU_TAR.tar.gz
wget https://dlcdn.apache.org/maven/maven-3/3.8.2/binaries/$MAVEN_TAR-bin.tar.gz
tar -C /opt/maven/ -xzf ./$MAVEN_TAR-bin.tar.gz
rm ./$MAVEN_TAR-bin.tar.gz