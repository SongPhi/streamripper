Tools for ripping off streams to restream or whatever

Based on Ubuntu 20.04 (focal)

Includes:

* [FFMPEG](https://ffmpeg.org)
* [Streamlink](https://streamlink.github.io/)

## Quick start

```
docker pull songphi/streamripper:latest
docker run -it songphi/streamripper:latest /bin/bash
```

Execute inside the container

```
streamlink --version
ffmpeg -L
```

## Example application


### Start datarhri/restreamer

```bash
export RS_USERNAME=admin
export RS_PASSWORD=datarhei
export RS_TOKEN=123456
export RTMP_HOST=127.0.0.1:1935
docker pull datarhei/restreamer:latest
docker run -d --name restreamer -e "RS_USERNAME=${RS_USERNAME}" -e "RS_PASSWORD=${RS_PASSWORD}" \
  -p 8080:8080 -p 1935:1935 -e "RS_TOKEN=${RS_TOKEN}" -v /mnt/restreamer/db:/restreamer/db \
  datarhei/restreamer:latest
```

### Stream-ripper

Create a new `Dockerfile` for stream-ripper process

```Dockerfile
FROM songphi/streamripper:latest

ADD ./run.sh /

CMD ["/run.sh"]
```

Create `run.sh` with following content

```bash
#!/bin/sh

streamlink -O "${YT_LINK}" "${VIDQ}" | ffmpeg -re -i pipe: -preset fast -tune zerolatency \
  -c:v libx264 -x264opts keyint=:no-scenecut -c:a aac -b:a 64k -muxdelay 0.1 -muxpreload 2 \
  -f flv "rtmp://${RTMP_HOST}/live/external.stream?token=${RTMP_TOKEN}"
```

```bash

```
