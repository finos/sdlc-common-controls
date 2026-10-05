.PHONY: build run clean readiness snapshot snapshot-check data data-nist data-ffiec data-owasp data-eu-ai-act

DOCKER_IMAGE := jekyll/jekyll
CONTAINER_NAME := sdlc-controls-jekyll
PORT := 4000

build: ## Build the Jekyll site
	docker run --rm \
		-v $(CURDIR)/docs:/srv/jekyll \
		$(DOCKER_IMAGE) \
		jekyll build

run: ## Run the Jekyll dev server on localhost:4000
	docker run --rm \
		--name $(CONTAINER_NAME) \
		-p $(PORT):$(PORT) \
		-v $(CURDIR)/docs:/srv/jekyll \
		$(DOCKER_IMAGE) \
		jekyll serve --host 0.0.0.0 --port $(PORT)

clean: ## Remove the generated _site directory and Jekyll cache
	rm -rf docs/_site docs/.jekyll-cache

readiness: ## Check document readiness and write readiness-report.md
	python3 scripts/readiness-check --report readiness-report.md

snapshot: ## Slice version snapshots for any cards whose version was bumped
	python3 scripts/version-snapshot

snapshot-check: ## Verify version snapshots are present and unchanged (CI)
	python3 scripts/version-snapshot --check

data: data-nist data-owasp data-eu-ai-act ## Regenerate regulatory reference data files (excludes FFIEC and ISO 42001, see RUNBOOK)

data-nist: ## Regenerate NIST SP 800-53r5 and AI 600-1 data files
	python3 scripts/dl_nist-sp-800-53r5.py
	python3 scripts/dl_nist-ai-600-1.py --leafs
	python3 scripts/readiness-check --update-checksums nist-sp-800-53r5 nist-ai-600-1

data-ffiec: ## Regenerate FFIEC IT Booklets data file (requires pandoc; currently blocked by a CAPTCHA on the source site, see RUNBOOK)
	python3 scripts/dl_ffiec-itbooklets.py --yml
	python3 scripts/readiness-check --update-checksums ffiec-itbooklets

data-owasp: ## Regenerate OWASP LLM and ML Top 10 data files
	python3 scripts/dl_owasp.py
	python3 scripts/readiness-check --update-checksums owasp-llm owasp-ml

data-eu-ai-act: ## Regenerate EU AI Act data file
	python3 scripts/dl_eu-ai-act.py
	python3 scripts/readiness-check --update-checksums eu-ai-act
