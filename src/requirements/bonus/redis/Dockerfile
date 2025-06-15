FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y redis-server

COPY conf/redis.conf /usr/local/etc/redis/redis.conf

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]