FROM ubuntu:16.04
MAINTAINER Matt Jenkins <matt@artdepartment.co.uk>

RUN apt-get update && apt-get install -y --no-install-recommends \
	nano \
	apache2 \
	php \
	libapache2-mod-php \
	php-cli \
	php-mcrypt \
	php-mysql \
	php-mbstring \
	php-gd \
	php-imagick \
	php-curl \
	php-intl \
	php-dom \
	php-zip \
	php-soap \
	php-xdebug \
	ssmtp
	
COPY site.conf /etc/apache2/sites-enabled/000-default.conf
COPY apache2-foreground /usr/local/bin/apache2-foreground
	
RUN echo "sendmail_path = /usr/sbin/ssmtp -t" > /etc/php/7.0/apache2/conf.d/sendmail.ini \
	&& echo "mailhub=mail:25\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf \
	&& echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf

RUN a2enmod rewrite \
	&& a2enconf  servername \
	&& apt-get autoremove -y -f \
    && apt-get clean -y \
    && rm -rf \
		/var/cache/apt/archives/* \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/* \
		/usr/share/doc/* \
		/usr/share/man/* \
		/usr/share/locale/* \
		/tmp/* \
	&& chmod +x /usr/local/bin/apache2-foreground

WORKDIR /var/www
	
#EXPOSE 80 443

CMD ["/usr/local/bin/apache2-foreground"]