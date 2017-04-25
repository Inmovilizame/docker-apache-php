FROM debian:jessie
MAINTAINER info@inmoviliza.me

# Rude and messy install 
# RUN apt-get -y update && \ 
#	apt-get -y upgrade && \
#	apt-get -y install apache2 php5
# ADD https://wordpress.org/latest.zip /var/www/html/
# COPY ./apacheconf/default.conf /etc/apache2/sites-available/000-default.conf
# RUN chmod -R 755 /var/www/html

# More detailed. Generate thinner containers
RUN apt-get update && \
	apt-get -y --no-install-recommends install unzip libapache2-mod-php5 php5-mysql php5-gd php5-curl && \ 
	rm -rf /var/cache/apt /var/lib/apt /var/lib/dpkg && \
	a2enmod rewrite headers && \
	sed -i -e 's:${APACHE_LOG_DIR}/access.log:/dev/stdout:' /etc/apache2/sites-available/* && \
	sed -i -e 's:${APACHE_LOG_DIR}/error.log:/dev/stderr:' /etc/apache2/sites-available/*

ADD https://wordpress.org/latest.zip /var/www/html/
RUN unzip /var/www/html/latest.zip -d /var/www/html/

EXPOSE 80
ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]
