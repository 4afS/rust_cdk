.PHONY: build/image
build/image:
	docker build -f Dockerfile -t rust_cdk:$(git describe --tags --always --dirty --abbrev=7) .