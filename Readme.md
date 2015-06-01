##This is the project for creating a container with all tools to build a container

#Installing docker and atomic command
1. yum install docker atomic
2. systemctl enable docker
3. systemctl start docker

#Building
* make image will build the container
* make push-image - will push the image to repositories
* make create-local - will create the container from image
* make set-root - set the root user container to ovirt


#Engine building
docker attach ovirt-engine-dev
login
go to /root and build the engine from there
use the ovirt.org instruction.
All tools are preinstalled
settings.xml is already there
