help:               ## Display this help message.
	@echo "Please use \`make <target>\` where <target> is one of:"
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | \
		awk -F ':.*?## ' 'NF==2 {printf "  %-26s%s\n", $$1, $$2}'

HUGO_IMAGE ?= fromcodetoprod/hugo:0.60.1-1

hugo:               ## Setup Hugo.
	docker pull $(HUGO_IMAGE)

build:              ## Build site.
	rm -fr public
	docker run --rm -v $(PWD):/site $(HUGO_IMAGE)

serve:              ## Serve development version.
	rm -fr public
	docker run --rm -p 1313:1313 -v $(PWD):/site $(HUGO_IMAGE) serve --bind=0.0.0.0 --buildDrafts
