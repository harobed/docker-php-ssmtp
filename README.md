# Php7 + Apache + SSMTP

This image add [ssmtp](https://wiki.archlinux.org/index.php/SSMTP) service to official
[Docker Php7 Apache image](https://github.com/docker-library/php/blob/fd8e15250a0c7667b161c34a25f7916b01f72367/7.2/stretch/apache/Dockerfile).

With *ssmtp** you can use buildin [mail](http://php.net/manual/en/function.mail.php) Php function
to send mails via smtp server configured by `SSMTP_*` environment variables.

This image enable also [Apache Rewrite mod](http://httpd.apache.org/docs/current/mod/mod_rewrite.html), *RewriteEngine* can be used in [.htaccess](www/.htaccess).

`docker-compose.yml` example to connect `apache` service to `postfix`:

```
version: '3'
services:
  apache:
    image: harobed/php-ssmtp:7-apache
    environment:
      - SSMTP_HOST=postfix
      - SSMTP_PORT=25
      - SSMTP_FROM_HOSTNAME=example.com
      - SSMTP_USE_TLS=Yes
      - SSMTP_USE_STARLTLS=Yes
      - SSMTP_AUTH_USER=user
      - SSMTP_AUTH_PASSWORD=password
    ports:
      - 80

  postfix:
    image: harobed/versatile-postfix:latest
    command: exemple.com user:password
    environment:
      - DISABLE_DKIM=1

networks:
  default:
    driver: bridge
```

See [Dockerfile](Dockerfile) to see environment variable default values.


## How to test

```
$ git clone https://github.com/harobed/docker-php-ssmtp.git
$ cd docker-php-ssmtp
$ docker-compose up -d
$ echo "Browse to http://`docker-compose port apache 80`"
```
