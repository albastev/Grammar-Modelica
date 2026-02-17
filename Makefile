IMAGE_NAME ?= grammar-modelica-test

.PHONY: docker-build docker-test docker-shell

docker-build:
	docker build -t $(IMAGE_NAME) .

docker-test:
	docker run --rm -v $(CURDIR):/app -w /app rakudo-star:latest prove -e "raku -Ilib" -r t

docker-shell:
	docker run --rm -it -v $(CURDIR):/app -w /app rakudo-star:latest
