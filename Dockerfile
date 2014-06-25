FROM triceio/trice-docker-base:latest
MAINTAINER John Axel Eriksson <john@insane.se>

ENV DEBIAN_FRONTEND noninteractive

ADD bootstrap.sh /root/bootstrap.sh
RUN chmod +x /root/bootstrap.sh && /root/bootstrap.sh && rm /root/bootstrap.sh

EXPOSE 80
CMD ["/usr/sbin/runsvdir-start"]
