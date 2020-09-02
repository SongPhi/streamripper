FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Ho_Chi_Minh
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y ffmpeg

RUN echo "deb http://ppa.launchpad.net/nilarimogard/webupd8/ubuntu focal main" > /etc/apt/sources.list.d/streamlink.list
RUN apt-get install -y gnupg2
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1DB29AFFF6C70907B57AA31F531EE72F4C9D234C
RUN apt-get update



RUN apt-get install -y streamlink



