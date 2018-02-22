.PHONY: build
build:
	docker build -t harobed/php-ssmtp:7-apache .

.PHONY: upload
upload:
	docker push harobed/php-ssmtp:7-apache
