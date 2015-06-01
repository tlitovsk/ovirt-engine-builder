# Building the containers makefile

# the repo to store the container , currently some local repo I use.
# TBD : to change to real one once acked
docker-repo?="$(shell echo $$USER)/"
container-name?=ovirt-engine-dev
root-pass?=ovirt

container/version-id.txt: Makefile
	@git log -1 > $@

image:
	docker build -f Dockerfile -t $(container-name):latest .

push-image: image
	docker tag -f vdsmc:latest $(docker-repo)$(container-name):latest
	docker push $(docker-repo)$(container-name):latest

create-local: image
	docker create -ti -v /sys/fs/cgroup:/sys/fs/cgroup --name $(container-name) $(container-name):latest

set-root:
	docker exec $(container-name) bash -c "echo 'root:$(root-pass)' | chpasswd"

all: image

clean :
	docker stop $(container-name) || true
	docker rm $(container-name) || trueterm
	docker rmi $(container-name) ||true

.PHONY: all image push-image create-local clean