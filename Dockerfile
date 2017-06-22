FROM andrdru/php-fpm

RUN echo "deb http://ftp.ru.debian.org/debian sid main" >> /etc/apt/sources.list

RUN apt-get update

RUN apt-get install php-dev -y

# Install Xdebug
RUN curl -fsSL 'https://xdebug.org/files/xdebug-2.5.1.tgz' -o xdebug.tar.gz
RUN ls
RUN mkdir -p xdebug
RUN tar -xf xdebug.tar.gz -C xdebug --strip-components=1
RUN rm xdebug.tar.gz
RUN mkdir test4
RUN	cd xdebug && phpize && ./configure --enable-xdebug && make -j$(nproc) && make install

RUN rm -r xdebug \
    && docker-php-ext-enable xdebug

#install composer
RUN apt-get install composer -y

#cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#new entrypoint
COPY entrypoint.sh /usr/local/bin/

#default xdebug config
COPY xdebug.ini /usr/local/etc/php/conf.d/
RUN chmod 777 /usr/local/etc/php/conf.d/xdebug.ini

RUN chmod 777 /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]