FROM ubuntu:26.04

RUN apt update && apt upgrade -y
RUN apt install -y dpkg-dev build-essential devscripts quilt
RUN sed -i 's/Types:\ deb/Types:\ deb\ deb-src/' /etc/apt/sources.list.d/ubuntu.sources
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt build-dep -y papers
