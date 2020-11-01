user=username
name=gate-resource
image=$(user)/$(name)
tag=2.0.0-beta1

docker=docker
dockerfile = Dockerfile

build:
	$(docker) build -t $(image):$(tag) -f $(dockerfile) .

push: build
	$(docker) push $(image):$(tag)
	$(docker) tag $(image):$(tag) $(image):latest
	$(docker) push $(image):latest
