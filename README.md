# php-8-laravel Docker image

This Docker image can be used as a base for Laravel applications based upon PHP 8.0.

In you own `Dockerfile`, you might want to use the following:

	FROM dreitier/php-8-laravel:latest
	WORKDIR /var/www/app
	COPY . ./
	RUN php /usr/local/bin/composer.phar install
	RUN npm install
	# set recursive write permissions to storage folder
	RUN chmod -R uag+w /var/www/app/storage
	RUN rm -rf /var/www/html \
		&&  ln -s /var/www/app/public/ /var/www/html
