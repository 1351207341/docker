FROM alpine_jdk8

# ensure elasticsearch user exists
RUN addgroup -S elasticsearch && adduser -S -G elasticsearch elasticsearch

# grab su-exec for easy step-down from root
# and bash for "bin/elasticsearch" among others
RUN apk add --no-cache 'su-exec>=0.2' bash

# https://artifacts.elastic.co/GPG-KEY-elasticsearch
ENV GPG_KEY 46095ACC8548582C1A2699A9D27D666CD88E42B4

WORKDIR /usr/share/elasticsearch
ENV PATH /usr/share/elasticsearch/bin:$PATH

ENV ELASTICSEARCH_VERSION 6.1.1
ENV ELASTICSEARCH_TARBALL="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.1.tar.gz" \
	ELASTICSEARCH_TARBALL_ASC="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.1.1.tar.gz.asc" \
	ELASTICSEARCH_TARBALL_SHA512="dcc23ef80ad2545490508d3e9db2fd0e6ae9a99cece0990f537c522265961dad234734548d1d86288af7f65a6ee681f5624d2c0e71df0e1dcc32fdb56dcefe92"

RUN set -ex; \
	\
	apk add --no-cache --virtual .fetch-deps \
		ca-certificates \
		gnupg \
		openssl \
		tar \
	; \
	\
	wget -O elasticsearch.tar.gz "$ELASTICSEARCH_TARBALL"; \
	\
	if [ "$ELASTICSEARCH_TARBALL_SHA512" ]; then \
		echo "$ELASTICSEARCH_TARBALL_SHA512 *elasticsearch.tar.gz" | sha512sum -c -; \
	fi; \
	\
	if [ "$ELASTICSEARCH_TARBALL_ASC" ]; then \
		wget -O elasticsearch.tar.gz.asc "$ELASTICSEARCH_TARBALL_ASC"; \
		export GNUPGHOME="$(mktemp -d)"; \
		gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$GPG_KEY"; \
		gpg --batch --verify elasticsearch.tar.gz.asc elasticsearch.tar.gz; \
		rm -rf "$GNUPGHOME" elasticsearch.tar.gz.asc; \
	fi; \
	\
	tar -xf elasticsearch.tar.gz --strip-components=1; \
	rm elasticsearch.tar.gz; \
	\
	apk del .fetch-deps; \
	\
	mkdir -p ./plugins; \
	for path in \
		./data \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
		chown -R elasticsearch:elasticsearch "$path"; \
	done; \
	\
# we shouldn't need much RAM to test --version (default is 2gb, which gets Jenkins in trouble sometimes)
	export ES_JAVA_OPTS='-Xms32m -Xmx32m'; \
	if [ "${ELASTICSEARCH_VERSION%%.*}" -gt 1 ]; then \
		elasticsearch --version; \
	else \
# elasticsearch 1.x doesn't support --version
# but in 5.x, "-v" is verbose (and "-V" is --version)
		elasticsearch -v; \
	fi

COPY config ./config

VOLUME /usr/share/elasticsearch/data

COPY docker-entrypoint.sh /

EXPOSE 9200 9300
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["elasticsearch"]
