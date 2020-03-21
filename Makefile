.PHONY: default validate

default: requirements.txt requirements-dev.txt validate

.terraform:
	terraform init

Pipfile.lock: Pipfile
	pipenv lock

requirements.txt: Pipfile.lock
	pipenv lock -r > $@

requirements-dev.txt: Pipfile.lock
	pipenv lock -r -d > $@

validate: | .terraform
	terraform validate
