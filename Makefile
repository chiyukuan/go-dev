
DOCKER_TAG  := quay.io/raykuan/golang-ide
DOCKER_FILE := package/docker/Dockerfile
KUBECONFIG  := ~/.kube/config_cl
#KUBECONFIG  := ~/.kube/config_c2
KUBEOPT     := --kubeconfig $(KUBECONFIG)
KUBEOPT_NS  := $(KUBEOPT) -n ray-devel

docker_build: $(DOCKER_FILE)
	docker build -f $< -t $(DOCKER_TAG) .

docker_push:
	docker push $(DOCKER_TAG):latest

docker_run:
	docker run --rm -ti -v `pwd`:/go $(DOCKER_TAG)

docker_retag:
	docker tag $(DOCKER_TAG):latest $(DOCKER_TAG):pre

docker_patch: $(DOCKER_FILE).patch
	docker build -f $< -t $(DOCKER_TAG) .

k8s_get_nodes: 
	kubectl $(KUBEOPT) get nodes

k8s_node_tag:
	@NODENAME=$$(kubectl $(KUBEOPT) get nodes -o jsonpath='{.items[0].metadata.name}') ; \
 	kubectl $(KUBEOPT) label nodes $$NODENAME devel-src=golang

k8s_golang:
	@PODNAME=$$(kubectl $(KUBEOPT_NS) get pod -o jsonpath='{.items[0].metadata.name}') ; \
	kubectl $(KUBEOPT_NS) exec -it $$PODNAME bash

k8s_node_name:
	NODENAME=$$(kubectl $(KUBEOPT) get nodes -o jsonpath='{.items[0].metadata.name}') ;\
	echo $$NODENAME

