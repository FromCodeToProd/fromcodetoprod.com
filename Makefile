help:               ## Display this help message.
	@echo "Please use \`make <target>\` where <target> is one of:"
	@grep '^[a-zA-Z]' $(MAKEFILE_LIST) | \
		awk -F ':.*?## ' 'NF==2 {printf "  %-26s%s\n", $$1, $$2}'

hugo:
	wget https://github.com/gohugoio/hugo/releases/download/v0.59.1/hugo_0.59.1_macOS-64bit.tar.gz -O hugo.tar.gz
	echo '4f9fad9a6a8da91f016a1f566281cbe6cfc11c16d8cd215d394813e5eaa318d6  hugo.tar.gz' | shasum -a 256 -c
	tar -xzf hugo.tar.gz
	rm hugo.tar.gz
	./hugo version

build: hugo         ## Build site.
	rm -fr public
	./hugo

serve: hugo         ## Serve development version.
	rm -fr public
	./hugo serve --buildDrafts
