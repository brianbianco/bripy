IMAGE_NAME := bripy
IMAGE_TAG  := latest

build:
	docker build --no-cache -t $(IMAGE_NAME):$(IMAGE_TAG) .

artifact:
	docker run --rm $(IMAGE_NAME):$(IMAGE_TAG) > bripy.tar.gz

run_model:
	docker run --rm $(IMAGE_NAME):$(IMAGE_TAG) python3 /root/inference.py

clean:
	@docker rmi $$(docker images --filter=reference='bripy:*' -q)
	rm bripy.tar.gz
