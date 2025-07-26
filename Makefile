# Assemble software specified in the Dockerfile 
build:
	docker build -t chk2_container .

# Depends on 'build' so running this recipe will also run 'build_image' 
# creates container and mounts the current folder content into the container (home/rstudio) 
run: build
	docker run --rm -it -p 8787:8787 \
	-e DISABLE_AUTH=true \
	--user $(id -u):$(id -g) \
	--name chk2_container \
	-v $(CURDIR):/home/rstudio/chk2 \
	chk2_container