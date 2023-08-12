##
#
##
NAME ?= alloy-cli

all: build
build: docker-build
clean: docker-clean
shell: docker-shell 
test: smoke-test 

docker-clean:
	docker rmi $(NAME) >/dev/null || true

docker-build:	
	docker build --no-cache -t $(NAME) .

docker-shell:
	docker run -it --rm -v `pwd`:/workspace -w /workspace \
		--entrypoint bash $(NAME)

smoke-test:
	docker run -it --rm -v `pwd`:/workspace -w /workspace \
		--entrypoint bash $(NAME) \
		-c 'alloy-run tests/knights.als'