PYTHON_VERSION := $(shell pyenv local)

all: test build validate

build: requirements.txt requirements-dev.txt

clean:
	rm -rf .terraform*
	pipenv --rm

validate: .terraform
	terraform validate

shell: .env
	docker run --rm -it --env-file .env -v $$PWD:/heroku -w /heroku python:$(PYTHON_VERSION) bash

test: .venv
	pipenv run black --check app.py

.PHONY: all clean validate shell test

.terraform:
	terraform init
	touch $@

.venv: Pipfile
	mkdir -p $@
	pipenv install --dev
	touch $@

Pipfile.lock: .venv
	pipenv lock

requirements.txt: Pipfile.lock
	pipenv requirements > $@

requirements-dev.txt: Pipfile.lock
	pipenv requirements --dev > $@
