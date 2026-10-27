.PHONY: install test lint run docker-build docker-run tf-init tf-plan tf-apply tf-destroy

install:
	npm install

test:
	npm test

lint:
	npm run lint

run:
	npm start

docker-build:
	docker build -t shiptrack:local .

docker-run:
	docker run --rm -p 3000:3000 shiptrack:local

tf-init:
	terraform -chdir=infra init

tf-plan:
	terraform -chdir=infra plan

tf-apply:
	terraform -chdir=infra apply

tf-destroy:
	terraform -chdir=infra destroy
