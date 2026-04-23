FROM alpine:3.21

RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-mbstring \
    php83-tokenizer \
    php83-phar \
    wget


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

RUN addgroup -S mygroup && adduser -S -G mygroup -u 1000 myuser


COPY conf/www.conf /etc/php83/php-fpm.d/www.conf
COPY conf/uploads.ini /etc/php83/conf.d/uploads.ini
WORKDIR /var/www/wordpress

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

CMD ["/init.sh"]
