DOCKER_IMAGE_NAME ?= alloy-cli

all: build
build: docker-build
clean: docker-clean
shell: docker-shell 
test: smoke-test 

docker-clean:
	docker rmi $(DOCKER_IMAGE_NAME) >/dev/null || true

docker-build:	
	docker build -t $(DOCKER_IMAGE_NAME) .

docker-shell:
	docker run -it --rm -v `pwd`:/workspace -w /workspace \
		--entrypoint bash $(DOCKER_IMAGE_NAME)

smoke-test:
	docker run --rm -v `pwd`:/workspace -w /workspace \
		$(DOCKER_IMAGE_NAME) tests/knights-satisfiable.als; \
	! docker run --rm -v `pwd`:/workspace -w /workspace \
		$(DOCKER_IMAGE_NAME) tests/knights-unsatisfiable.als