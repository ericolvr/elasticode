
build:
	docker build -t oliveiraerico/elasticode .

push:
	docker push oliveiraerico/elasticode


PHONY: build, push 