FROM alpine
MAINTAINER lorenwe
LABEL maintainer "lorenwe <lorenwe@kaolanet.com>" architecture="AMD64/x86_64" version="10.1.28" date="25-nov-2017"

RUN apk --update add mariadb mariadb-client

ADD files/mariadb_init.sh /mariadb_init.sh
ADD files/run.sh /run.sh
ADD files/my.cnf /etc/mysql/my.cnf

RUN chmod 775 *.sh && \
	chown -R mysql:mysql /var/lib/mysql && \
	chmod -R 777 /var/lib/mysql && \
	chmod 644 /etc/mysql/my.cnf && \
	chmod -R 777 /tmp


VOLUME  ["/var/lib/mysql"]

EXPOSE 3306

ENV TERM dumb

CMD ["sh", "run.sh"]