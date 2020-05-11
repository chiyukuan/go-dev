
docker_build:
	docker build -f Dockerfile -t quay.io/raykuan/golang-ide .

docker_build1:
	docker build -f Dockerfile1 -t quay.io/raykuan/golang-ide1 .

docker_build2:
	docker build -f Dockerfile2 -t quay.io/raykuan/golang-ide .

docker_push:
	docker push quay.io/raykuan/golang-ide:latest

docker_run:
	docker run --rm -ti -v `pwd`:/go quay.io/raykuan/golang-ide
