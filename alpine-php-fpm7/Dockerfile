FROM alpine

LABEL maintainer "lorenwe <lorenwe@kaolanet.com>" architecture="AMD64/x86_64"  phpversion="7.1"

RUN apk --update add \
        php7-gd \
        bash \
        curl \
        php7 \
        php7-dom \
        php7-ctype \
        php7-curl \
        php7-fpm \
        php7-intl \
        php7-json \
        php7-mbstring \
        php7-mcrypt \
        php7-mysqlnd \
        php7-opcache \
        php7-pdo \
        php7-pdo_mysql \
        php7-posix \
        php7-session \
        php7-xml \
        php7-iconv \
        php7-phar \
        php7-openssl \
    && rm -rf /var/cache/apk/*

COPY php.ini /etc/php7/conf.d/50-setting.ini
COPY php-fpm.conf /etc/php7/php-fpm.conf

#RUN ln -s /usr/bin/php7 /usr/bin/php

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 

VOLUME /app
EXPOSE 9000

CMD ["php-fpm7", "-F"]