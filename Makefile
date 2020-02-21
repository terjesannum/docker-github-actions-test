GEM_VERSION_NAIS_LOG_PARSER    = 0.39.4

IMAGE_NAME = foo

.PHONY: docker clean check-tag

all: docker

clean:
	rm -f *.gem

check-tag:
	test $(TAG)

docker: check-tag nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem
	docker build \
	--build-arg GEM_VERSION_NAIS_LOG_PARSER=$(GEM_VERSION_NAIS_LOG_PARSER) \
	-t docker.pkg.github.com/${GITHUB_REPOSITORY}/${IMAGE_NAME}:$(TAG) .

nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem:
	gem fetch nais-log-parser --version "$(GEM_VERSION_NAIS_LOG_PARSER)" --source "https://x-access-token:$(GITHUB_TOKEN)@rubygems.pkg.github.com/nais" && \
	test -r nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem
