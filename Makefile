PROJECT = $(shell basename ${PWD})
DIR_ROOT = $(realpath $(CURDIR))
DIR_OUT = _output

ZIG_VERSION = 0.15.2
GRADLE_VERSION = 8.7
CTR_IMAGE_BASE = alpine:3.21
LOCALSTACK_IMG = localstack/localstack:4.3.0

AWS_MODELS_COMMIT = fc44394485733bfdbe094a708e4b3963d31bd75d

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
		$(CTR_IMAGE_LOCAL) /bin/sh -c "zig build $(ZIG_BUILD_FLAGS)"

test: $(HAS_IMAGE_LOCAL)
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-w /code \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "zig build test $(ZIG_BUILD_FLAGS)"

test-integration: $(HAS_IMAGE_LOCAL)
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--group-add $(DOCKER_GID) \
		--security-opt label=type:container_runtime_t \
		--network host \
		-e LOCALSTACK_IMG=$(LOCALSTACK_IMG) \
		-e "ZIG_BUILD_FLAGS=$(ZIG_BUILD_FLAGS)" \
		-e SCENARIO=$(SCENARIO) \
		-w /code \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "./tests/integration/run.sh"

test-integration-tls: $(HAS_IMAGE_LOCAL) certs
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-v /var/run/docker.sock:/var/run/docker.sock \
		--group-add $(DOCKER_GID) \
		--security-opt label=type:container_runtime_t \
		--network host \
		-e LOCALSTACK_IMG=$(LOCALSTACK_IMG) \
		-e "ZIG_BUILD_FLAGS=$(ZIG_BUILD_FLAGS)" \
		-e SCENARIO=$(SCENARIO) \
		-w /code \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "./tests/integration/run.sh --tls"

SERVICES = sts dynamodb lambda s3 ec2 iam

fetch-models: | $(DIR_OUT)
	@curl -sL -o $(DIR_OUT)/api-models-aws.zip \
		"https://codeload.github.com/aws/api-models-aws/zip/$(AWS_MODELS_COMMIT)"
	@unzip -qo $(DIR_OUT)/api-models-aws.zip -d $(DIR_OUT)
	@mkdir -p codegen/sdk-codegen/model
	@cp $(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/models/sts/service/2011-06-15/sts-2011-06-15.json \
		codegen/sdk-codegen/model/sts.json
	@cp $(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/models/dynamodb/service/2012-08-10/dynamodb-2012-08-10.json \
		codegen/sdk-codegen/model/dynamodb.json
	@cp $(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/models/lambda/service/2015-03-31/lambda-2015-03-31.json \
		codegen/sdk-codegen/model/lambda.json
	@cp $(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/models/s3/service/2006-03-01/s3-2006-03-01.json \
		codegen/sdk-codegen/model/s3.json
	@cp $(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/models/ec2/service/2016-11-15/ec2-2016-11-15.json \
		codegen/sdk-codegen/model/ec2.json
	@cp $(DIR_OUT)/api-models-aws-$(AWS_MODELS_COMMIT)/models/iam/service/2010-05-08/iam-2010-05-08.json \
		codegen/sdk-codegen/model/iam.json

codegen: $(HAS_IMAGE_LOCAL) fetch-models
	@docker run --rm \
		-v $(DIR_ROOT):/code \
		-w /code \
		$(CTR_IMAGE_LOCAL) /bin/sh -c "cd codegen && gradle build --gradle-user-home /code/$(DIR_OUT)/gradle-home --project-cache-dir /code/$(DIR_OUT)/codegen/.gradle"
	@for svc in $(SERVICES); do \
		rm -rf service/$${svc}; \
		mkdir -p service/$${svc}; \
		cp $(DIR_OUT)/codegen/sdk-codegen/smithyprojections/sdk-codegen/$${svc}/zig-codegen/*.zig service/$${svc}/; \
	done

certs:
	@bash tests/integration/certs/generate.sh

clean:
	@rm -rf $(DIR_OUT)

.PHONY: build test test-integration test-integration-tls fetch-models codegen certs clean
