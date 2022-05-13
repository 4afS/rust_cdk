.PHONY: build/image
build/image:
	docker build -f Dockerfile -t rust_cdk .
