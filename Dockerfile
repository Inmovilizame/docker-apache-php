FROM debian:jessie
MAINTAINER info@inmoviliza.me
RUN apt-get -y update && \ 
	apt-get -y upgrade && \
	apt-get -y install apache2 php5
ADD https://wordpress.org/latest.zip /var/www/html/
COPY ./apacheconf/default.conf /etc/apache2/sites-available/000-default.conf
RUN chmod -R 755 /var/www/html
EXPOSE 80
#ENTRYPOINT ["/bin/bash"]
ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]
