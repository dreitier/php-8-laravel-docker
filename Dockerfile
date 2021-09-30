FROM php:8.0.9-apache

LABEL org.opencontainers.image.authors="ckl@dreitier.com"
LABEL description="Starter image for Laravel-based application using PHP 8.0"

RUN apt-get update -y \
    && apt-get install -y libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev zlib1g-dev libonig-dev libzip-dev npm

RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install zip
RUN docker-php-ext-configure gd
RUN docker-php-ext-install gd

RUN apt-get remove -y libwebp-dev libjpeg62-turbo-dev libpng-dev libxpm-dev libfreetype6-dev zlib1g-dev libonig-dev libzip-dev \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/

# enable mod_rewrite for Laravel
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled

WORKDIR /var/www/app
RUN php -m
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    &&  php -r "if (hash_file('sha384', 'composer-setup.php') === '77b8aca1b41174a67f27be066558f8a96f489916f4cded2bead3cab6a3f33590') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    &&  php composer-setup.php --install-dir=/usr/local/bin \
    &&  php -r "unlink('composer-setup.php');"