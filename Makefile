# Assemble software specified in the Dockerfile 
build_image:
	docker build -t chk2_container .

# Depends on 'build_image' so running this recipe will also run 'build_image' 
# creates container and mounts the current folder content into the container (home/rstudio) 
run_container: build_image
	docker run --rm -it -p 8787:8787 \
	-e PASSWORD=dummy \
	-e USERID=$(id -u) -e GROUPID=$(id -g) \
	--name chk2_container \
	-v $(CURDIR):/home/rstudio/chk2 \
	chk2_container