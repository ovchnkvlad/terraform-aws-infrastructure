TERRAFORM_IMAGE := hashicorp/terraform:1.17.1
TFLINT_IMAGE := ghcr.io/terraform-linters/tflint:v0.64.0
TRIVY_IMAGE := aquasec/trivy:0.76.2

.PHONY: fmt fmt-check init validate lint scan check

fmt:
	docker run --rm --volume "$(CURDIR):/workspace" --workdir /workspace $(TERRAFORM_IMAGE) fmt -recursive

fmt-check:
	docker run --rm --volume "$(CURDIR):/workspace:ro" --workdir /workspace $(TERRAFORM_IMAGE) fmt -check -recursive

init:
	docker run --rm --volume "$(CURDIR):/workspace" --workdir /workspace $(TERRAFORM_IMAGE) init -backend=false -input=false

validate: init
	docker run --rm --volume "$(CURDIR):/workspace:ro" --workdir /workspace $(TERRAFORM_IMAGE) validate

lint:
	docker run --rm --volume "$(CURDIR):/workspace:ro" $(TFLINT_IMAGE) --chdir=/workspace --recursive

scan:
	docker run --rm --volume "$(CURDIR):/workspace:ro" $(TRIVY_IMAGE) config --exit-code 1 --severity HIGH,CRITICAL /workspace

check: fmt-check validate lint scan
