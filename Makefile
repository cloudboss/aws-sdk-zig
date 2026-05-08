PROJECT = $(shell basename ${PWD})
DIR_ROOT = $(realpath $(CURDIR))
DIR_OUT = _output

ZIG_VERSION = 0.16.0
GRADLE_VERSION = 8.7
CTR_IMAGE_BASE = ghcr.io/cloudboss/docker.io/library/alpine:3.23.2
CTR_IMAGE_LOCALSTACK = ghcr.io/cloudboss/docker.io/localstack/localstack:4.14.0

AWS_MODELS_COMMIT = 3c0aa29b303909ce69f0e3bb4a4638a0f21a34a8

# The Dockerfile and its args are hashed to create a unique tag. The image
# will be rebuilt if the hash changes, as the dependency file will change.
UID = $(shell id -u)
GID = $(shell id -g)
UID_SHA256 = $(shell echo -n $(UID) | sha256sum | awk '{print $$1}')
GID_SHA256 = $(shell echo -n $(GID) | sha256sum | awk '{print $$1}')
CTR_IMAGE_BASE_SHA256 = $(shell echo -n $(CTR_IMAGE_BASE) | sha256sum | awk '{print $$1}')
ZIG_VERSION_SHA256 = $(shell echo -n $(ZIG_VERSION) | sha256sum | awk '{print $$1}')
GRADLE_VERSION_SHA256 = $(shell echo -n $(GRADLE_VERSION) | sha256sum | awk '{print $$1}')
DOCKERFILE_SHA256 = $(shell sha256sum Dockerfile.build | awk '{print $$1}')
DOCKER_INPUTS_SHA256 = $(shell echo -n $(UID_SHA256)$(GID_SHA256)$(CTR_IMAGE_BASE_SHA256)$(ZIG_VERSION_SHA256)$(GRADLE_VERSION_SHA256)$(DOCKERFILE_SHA256) | \
	sha256sum | awk '{print $$1}' | cut -c 1-40)
CTR_IMAGE_LOCAL = $(PROJECT):$(DOCKER_INPUTS_SHA256)
HAS_IMAGE_LOCAL = $(DIR_OUT)/.image-local-$(DOCKER_INPUTS_SHA256)

ZIG_BUILD_FLAGS = --cache-dir $(DIR_OUT)/zig-cache --global-cache-dir $(DIR_OUT)/zig-cache

DOCKER_GID = $(shell getent group docker | cut -d: -f3)

.DEFAULT_GOAL = build

$(DIR_OUT):
	@mkdir -p $(DIR_OUT)

$(DIR_OUT)/%/:
	@mkdir -p $(DIR_OUT)/$*

$(HAS_IMAGE_LOCAL): | $(DIR_OUT)/dockerbuild/
	@docker build \
		--build-arg FROM=$(CTR_IMAGE_BASE) \
		--build-arg GID=$(GID) \
		--build-arg UID=$(UID) \
		--build-arg ZIG_VERSION=$(ZIG_VERSION) \
		--build-arg GRADLE_VERSION=$(GRADLE_VERSION) \
		-f $(DIR_ROOT)/Dockerfile.build \
		-t $(CTR_IMAGE_LOCAL) \
		$(DIR_OUT)/dockerbuild
	@touch $(HAS_IMAGE_LOCAL)

build: $(HAS_IMAGE_LOCAL)
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-w /code \
		--security-opt label=type:container_runtime_t \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "zig build $(ZIG_BUILD_FLAGS)"

test: $(HAS_IMAGE_LOCAL)
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-w /code \
		--security-opt label=type:container_runtime_t \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "zig build test $(ZIG_BUILD_FLAGS)"

test-integration-localstack: $(HAS_IMAGE_LOCAL) certs | $(DIR_OUT)
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v $(DIR_ROOT)/tests/integration/tls-hosts:/etc/hosts \
		--group-add $(DOCKER_GID) \
		--security-opt label=type:container_runtime_t \
		-e CTR_IMAGE_LOCALSTACK=$(CTR_IMAGE_LOCALSTACK) \
		-e "ZIG_BUILD_FLAGS=$(ZIG_BUILD_FLAGS)" \
		-e SCENARIO=$(SCENARIO) \
		-e SCENARIO_TIMEOUT_SECS \
		-e AWS_CA_BUNDLE=/code/tests/integration/certs/ca.crt \
		-e TLS_CERT_HOST_PATH=$(DIR_ROOT)/tests/integration/certs/server.pem \
		-w /code \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "./tests/integration/scenarios-localstack/run.sh"

test-integration-live: $(HAS_IMAGE_LOCAL) | $(DIR_OUT)
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-v $(HOME)/.aws:/home/build/.aws:ro \
		--security-opt label=type:container_runtime_t \
		-e AWS_ACCESS_KEY_ID \
		-e AWS_SECRET_ACCESS_KEY \
		-e AWS_SESSION_TOKEN \
		-e AWS_PROFILE \
		-e AWS_DEFAULT_REGION \
		-e "ZIG_BUILD_FLAGS=$(ZIG_BUILD_FLAGS)" \
		-e SCENARIO=$(SCENARIO) \
		-e SCENARIO_TIMEOUT_SECS \
		-w /code \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "./tests/integration/scenarios-live/run.sh"

# Set SERVICES_FILTER to a comma-separated list to generate only a subset,
# e.g.: SERVICES_FILTER=sts,s3 make codegen
SERVICES_FILTER ?=

$(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/README.md: | $(DIR_OUT)
	@curl -sL -o $(DIR_OUT)/api-models-aws.zip \
		"https://codeload.github.com/aws/api-models-aws/zip/$(AWS_MODELS_COMMIT)"
	@unzip -qo $(DIR_OUT)/api-models-aws.zip -d $(DIR_OUT)

fetch-models: $(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/README.md

codegen: $(HAS_IMAGE_LOCAL) fetch-models
	@SERVICES_FILTER="$(SERVICES_FILTER)" \
		DIR_OUT="$(DIR_OUT)" \
		AWS_MODELS_COMMIT="$(AWS_MODELS_COMMIT)" \
		CTR_IMAGE="$(CTR_IMAGE_LOCAL)" \
		DIR_ROOT="$(DIR_ROOT)" \
		python3 hack/run-codegen

codegen-%: $(HAS_IMAGE_LOCAL) fetch-models
	@SERVICES_FILTER="$*" \
		DIR_OUT="$(DIR_OUT)" \
		AWS_MODELS_COMMIT="$(AWS_MODELS_COMMIT)" \
		CTR_IMAGE="$(CTR_IMAGE_LOCAL)" \
		DIR_ROOT="$(DIR_ROOT)" \
		python3 hack/run-codegen

docs: $(HAS_IMAGE_LOCAL) fetch-models
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-w /code \
		--security-opt label=type:container_runtime_t \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "zig build docs $(ZIG_BUILD_FLAGS) --prefix $(DIR_OUT)/zig-out"
	@hack/generate-docs-index $(DIR_OUT)/zig-out/docs hack/services.txt \
		$(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)

certs:
	@bash tests/integration/certs/generate.sh

clean:
	@rm -rf $(DIR_OUT)

.PHONY: build test test-integration-localstack test-integration-live fetch-models codegen docs certs clean
