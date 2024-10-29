
default:
	echo pass

NAMESPACE=phlummox/
IMAGE=texlive
TAG=0.2

DOCKER = docker
BUILD_ARGS =

build:
	$(DOCKER) build $(BUILD_ARGS) \
	  -t $(NAMESPACE)$(IMAGE):$(TAG) \
	  -t $(NAMESPACE)$(IMAGE):latest \
	  -f Dockerfile .

# a few targets for printing useful info about the image. i.e., we use the
# makefile as the source of truth.

print-image-namespace:
	@echo $(NAMESPACE)

print-image-name:
	@echo $(IMAGE)

print-image-version:
	@echo $(TAG)

# override this with desired bind-mounts, if needed
MOUNTS =

run:
	$(DOCKER) -D run -e DISPLAY --rm -it --net=host  \
	  $(MOUNTS) \
	  -v $$PWD:/work --workdir /work \
	  $(NAMESPACE)$(IMAGE):$(TAG)

