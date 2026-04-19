FROM alpine:3.21

RUN apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-mbstring \
    php83-ctype \
    php83-tokenizer \
    php83-curl \
    php83-phar \
    wget

RUN ln -sf /usr/bin/php83 /usr/bin/php


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp



# RUN adduser -D -u 1000 myuser || true
# Create a system group and user with a fixed ID
RUN addgroup -S mygroup && adduser -S -G mygroup -u 1000 myuser


COPY conf/www.conf /etc/php83/php-fpm.d/www.conf


WORKDIR /var/www/wordpress

COPY tools/init.sh /init.sh
RUN chmod +x /init.sh

EXPOSE 9000

CMD ["/init.sh"]
