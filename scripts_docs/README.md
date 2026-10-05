# Scripts

This directory contains scripts for downloading external references, processing governance framework files, and maintaining project consistency.

## dl_ffiec-itbooklets.py
   - Downloads and converts FFIEC IT Handbook booklets to Markdown format.
   - Generates YAML mappings, downloads HTML files (with navigation filtering), and converts to Markdown using pandoc.
   - Requires: `pip install requests beautifulsoup4 pyyaml` and `pandoc`
   - Usage: `python dl_ffiec-itbooklets.py --all` (or `--yml`, `--html`, `--md` individually)

## dl_eu-ai-act.py
   - Downloads EU AI Act Explorer content and extracts table of contents and annexes into structured Markdown and YAML files.
   - Generates `eu-ai-act-toc.md` (human-readable) and `eu-ai-act.yml` (machine-readable) with hierarchical document structure.
   - Requires: `pip install requests beautifulsoup4 pyyaml roman`
   - Usage: `python dl_eu-ai-act.py` (add `--download` to force fresh download)

## dl_owasp.py
   - Unified downloader for OWASP projects (LLM Top 10, ML Security Top 10).
   - Configuration-driven approach supports multiple OWASP projects with different metadata extraction methods.
   - Downloads markdown files and generates YAML mappings with normalized keys for Jekyll integration.
   - Requires: `pip install requests pyyaml`
   - Usage: `python dl_owasp.py [llm|ml|all]` (default: all)

## dl_nist-sp-800-53r5.py
   - Dedicated generator for `docs/_data/nist-sp-800-53r5.yml`.
   - Downloads the PDF if needed, reads it page by page with `pypdf`, extracts base control codes and titles from text, and prefers bookmark-derived deep links with page-link fallback.
   - Warns when control numbering within a family is not consecutive. Use `--strict` to fail on gaps.
   - Requires: `pip install requests pypdf pyyaml`
   - Usage: `python3 scripts/dl_nist-sp-800-53r5.py`

## dl_nist-ai-600-1.py
   - Dedicated generator for `docs/_data/nist-ai-600-1.yml`.
   - Downloads the AI 600-1 PDF if needed, extracts bookmarks, filters to the configured section, and emits deep links from the PDF outline.
   - Requires: `pip install requests pypdf pyyaml`
   - Usage: `python3 scripts/dl_nist-ai-600-1.py --leafs`

## annotate_yaml_front_matter.py
   - Adds title comments to YAML front matter in risk and mitigation files for better readability.
   - Processes reference sections (NIST, FFIEC, OWASP, EU AI Act), risks, and mitigations to create cross-referenced annotations.
   - Automatically derives YAML filenames from reference types in docs/_data/ directory.
   - Requires: `pip install PyYAML`
   - Usage: `python annotate_yaml_front_matter.py`

## rename-with-titles
   - Renames risk and mitigation files to include their titles in the filename.
   - Supports dry-run mode for preview and separate processing of risks vs mitigations.
   - Usage: `./rename-with-titles --ri --dryrun` or `./rename-with-titles --mi`

## lint-check
   - Validates filename conventions and project structure consistency.
   - Checks that files follow expected naming patterns.
   - Usage: `./lint-check`

## readiness-check
   - Validates that risk and mitigation documents meet the criteria required for Working-Group approval.
   - Complements `lint-check` with content-level checks: required sections, non-empty `mitigates` links, at least one regulatory reference, and cross-references that resolve to existing files.
   - Supports scoped validation for pull requests via `--files`, while still resolving cross-references against the full repository.
   - Writes `readiness-report.md` with a per-document status table and a risk–mitigation coverage matrix when `--report` is passed.
   - When `--files` and `--report` are used without an explicit output path, the scoped report is written to `readiness-report.changed.md`.
   - Checks every `docs/_data/*.yml` file against `scripts/checked-in-checksums.yml`, flagging a missing file or unrecorded content change (hand-edited or regenerated) even without `--show-missing-frameworks`.
   - Requires: `pip install PyYAML`
   - Usage: `python readiness-check --report readiness-report.md`, `python readiness-check --files docs/_risks/ri-1_insider-threat.md`, `python readiness-check --update-checksums`, or `make readiness`

## version-snapshot
   - Materialises an immutable, per-card version history into the `docs/_versions` Jekyll collection, so every mitigation and risk can be queried and displayed by its version — all in-repo, no database.
   - Each card carries one authored field in its front matter, `version: "0.1"`. To slice a new version you bump that single line and run the script; it writes a verbatim, frozen copy to `docs/_versions/<id>-v<version>.md`, stamped with the slice date, git commit, and a content hash.
   - `--check` enforces immutability: if a card's content changed but its already-sliced version was not bumped, it fails (so CI can require a version bump or a restore). `--init [VERSION]` adds a `version` field to any card missing one (default `0.1`).
   - Snapshots are generated artefacts — never hand-edit them. The site renders them via the `version` layout with a historic-version banner and a version-history panel on each live card.
   - Requires: `pip install PyYAML`
   - Usage: `make snapshot` (slice new versions), `make snapshot-check` (CI), `./scripts/version-snapshot --init`, or `./scripts/version-snapshot --files docs/_mitigations/mi-1_code-review.md`

---

## Legacy Scripts
The following scripts are superseded by the unified versions above:
- `dl_owasp_llm.py` → Use `dl_owasp.py llm`
- `dl_owasp_ml.py` → Use `dl_owasp.py ml`
