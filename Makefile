user=eth-brownie
name=kebabci
image=$(user)/$(name)
tag=1.0.2

docker=docker
dockerfile = Dockerfile

build:
	$(docker) build -t $(image):$(tag) -f $(dockerfile) .

push: build
	$(docker) push $(image):$(tag)
	$(docker) tag $(image):$(tag) $(image):latest
	$(docker) push $(image):latest
