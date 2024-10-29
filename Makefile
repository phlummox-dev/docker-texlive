
default:
	echo pass

NAME=phlummox/latex
TAG=0.1

build:
	docker build \
	  -t $(NAME):$(TAG) \
	  -t $(NAME):latest \
	  .

# override this with desired bind-mounts, if needed
MOUNTS =

run:
	docker -D run -e DISPLAY --rm -it --net=host  \
	  $(MOUNTS) \
	  -v $$PWD:/work --workdir /work \
	  $(NAME):$(TAG) 

