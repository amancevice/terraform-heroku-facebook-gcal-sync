PYTHON_VERSION := $(shell cat runtime.txt)

default: requirements.txt requirements-dev.txt validate

clean:
	rm -rf .terraform

validate: | .terraform
	terraform validate

shell: .env
	docker run --rm -it --env-file .env -v $$PWD:/heroku -w /heroku python:$(PYTHON_VERSION) bash

.PHONY: default clean validate shell

.terraform:
	terraform init

Pipfile.lock: Pipfile
	pipenv lock

requirements.txt: Pipfile.lock
	pipenv lock -r > $@

requirements-dev.txt: Pipfile.lock
	pipenv lock -r -d > $@
