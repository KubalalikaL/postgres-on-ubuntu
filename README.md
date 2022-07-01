# postgres-on-ubuntu
The base OS is Ubuntu 18.04 then we have postgresql installed on top with a default user&amp; schema that can be changed by making a few changes to the dockerfile

# To build the image
docker build -t postgres-db .

# To run the container in an interactive shell
docker run -it --name postgres postgres-db


# OR
# To run a detached container mapped to any random port
docker run -d --name postgres-db -P postgres-db

# To run an bash shell for the created container
docker exec -it postgres-db bash

