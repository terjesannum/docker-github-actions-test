GEM_VERSION_NAIS_LOG_PARSER = 0.39.4

GITHUB_REPOSITORY = terjesannum/docker-github-actions-test
IMAGE_NAME        = foo
IMAGE_TAG         = 0

.PHONY: all docker clean check-vars

all: docker

clean:
	rm -f *.gem

check-vars:
	@test $(GITHUB_TOKEN) || echo "GITHUB_TOKEN not set" && test $(GITHUB_TOKEN)
	@test "$(IMAGE_TAG)" != "0" || echo "Warning: Using default image tag: 0"

docker: check-vars nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem
	docker build \
	--build-arg GEM_VERSION_NAIS_LOG_PARSER=$(GEM_VERSION_NAIS_LOG_PARSER) \
	-t docker.pkg.github.com/${GITHUB_REPOSITORY}/${IMAGE_NAME}:$(IMAGE_TAG) .

nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem:
	gem fetch nais-log-parser --version "$(GEM_VERSION_NAIS_LOG_PARSER)" --source "https://x-access-token:$(GITHUB_TOKEN)@rubygems.pkg.github.com/nais"
	test -r nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem
