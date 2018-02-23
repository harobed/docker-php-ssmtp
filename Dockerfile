FROM php:7-apache

RUN a2enmod rewrite
COPY 000-default.conf /etc/apache2/sites-available/000-default.conf

RUN curl -L https://github.com/hairyhenderson/gomplate/releases/download/v2.3.0/gomplate_linux-amd64-slim > /usr/local/bin/gomplate && \
  chmod u+x /usr/local/bin/gomplate

COPY ./ssmtp.conf.tmpl /ssmtp.conf.tmpl

RUN apt-get update && \
  apt-get install -y ssmtp && \
  apt-get clean && \
  echo 'sendmail_path = "/usr/sbin/ssmtp -t"' > /usr/local/etc/php/conf.d/mail.ini

ENV SSMTP_HOST=postfix
ENV SSMTP_PORT=25
ENV SSMTP_FROM_HOSTNAME=example.com
ENV SSMTP_USE_TLS=Yes
ENV SSMTP_USE_STARLTLS=Yes
ENV SSMTP_AUTH_USER=user
ENV SSMTP_AUTH_PASSWORD=password

COPY ./docker-entrypoint.sh /
RUN chmod u+x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
