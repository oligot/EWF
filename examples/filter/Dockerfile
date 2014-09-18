FROM debian:wheezy
MAINTAINER Olivier Ligot <oligot@gmail.com>

RUN apt-get update && apt-get -y install apache2 libapache2-mod-fcgid libfcgi-dev
RUN mkdir -p /var/app/filter
ADD filter /var/app/filter/filter
ADD apache.conf /etc/apache2/sites-available/filter
RUN a2enmod proxy_http rewrite && a2dissite default && a2ensite filter && echo "Listen 9090" >> /etc/apache2/ports.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
