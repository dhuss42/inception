FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		curl \
		tar && \
	curl -L -o portainer.tar.gz https://github.com/portainer/portainer/releases/download/2.27.6/portainer-2.27.6-linux-ppc64le.tar.gz && \


CMD ["/bin/bash"]