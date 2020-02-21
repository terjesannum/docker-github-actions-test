GEM_VERSION_NAIS_LOG_PARSER = 0.39.4

.PHONY: all docker clean check-vars

all: docker

clean:
	rm -f *.gem

check-vars:
	test $(IMAGE_NAME)
	test $(TAG)

docker: check-vars nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem
	docker build \
	--build-arg GEM_VERSION_NAIS_LOG_PARSER=$(GEM_VERSION_NAIS_LOG_PARSER) \
	-t docker.pkg.github.com/${GITHUB_REPOSITORY}/${IMAGE_NAME}:$(TAG) .

nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem:
	gem fetch nais-log-parser --version "$(GEM_VERSION_NAIS_LOG_PARSER)" --source "https://x-access-token:$(GITHUB_TOKEN)@rubygems.pkg.github.com/nais"
	test -r nais-log-parser-$(GEM_VERSION_NAIS_LOG_PARSER).gem
