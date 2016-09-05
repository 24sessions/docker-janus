TEMPLATE_NAME ?= 24sessions/docker-janus

run: 
	@docker run -tid -p 7889:7889 -p 7089:7089 -p 8089:8889 -p 7088:7088 -p 8088:8088 -p 8000:8000 -p 8080:8080 -p 10000-10200:10000-10200 -p 8188:8188 -p 8989:8989 \
$(TEMPLATE_NAME) --name janus

shell: image
	@docker run -p 0.0.0.0:7889:7889 -p 0.0.0.0:8089:8089 -a stdin -a stdout -i -t $(TEMPLATE_NAME) /bin/bash

image:
	@docker build -t $(TEMPLATE_NAME) .

stop:
	docker ps | grep janus | cut -f1 -d' ' | xargs docker stop
