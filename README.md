## JANUS Gateway + Docker
This Docker container provides a fully configured [Janus Gateway](https://github.com/meetecho/janus-gateway) from Meetecho w/ Event API and Demo Server for quick prototyping of Janus plugins

### Docker Images
Images for this container are available at https://hub.docker.com/r/qxip/docker-janus

#### Docker Run & Mapping
The following command should provide a fully functional container w/ basic mapping
```
docker run -tid \
-p 7889:7889 -p 7089:7089 -p 8089:8889 -p 7088:7088 -p 8088:8088 -p 8000:8000 \
-p 8080:8080 -p 10000-10200:10000-10200 -p 8188:8188 -p 8989:8989 \
24sessions/docker-janus --name janus
```
