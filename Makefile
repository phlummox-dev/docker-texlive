
default:
	echo pass

NAMESPACE=phlummox/
NAME=texlive
TAG=0.1

build:
	docker build \
	  -t $(NAMESPACE)$(NAME):$(TAG) \
	  -t $(NAMESPACE)$(NAME):latest \
	  .

# override this with desired bind-mounts, if needed
MOUNTS =

run:
	docker -D run -e DISPLAY --rm -it --net=host  \
	  $(MOUNTS) \
	  -v $$PWD:/work --workdir /work \
	  $(NAMESPACE)$(NAME):$(TAG)

