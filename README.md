[![FINOS - Incubating](https://cdn.jsdelivr.net/gh/finos/contrib-toolbox@master/images/badge-incubating.svg)](https://community.finos.org/docs/governance/lifecycle-stages/incubating)

# SDLC Common Controls Catalog

> **[View the live site](https://sdlc-common-controls.finos.org/)**

The SDLC Common Controls Catalog Working Group aims to create a shared, open reference library for software governance controls across the financial services industry. By establishing common definitions, implementations, and patterns, we reduce duplication, prevent drift, and enable institutions to focus on innovation rather than reinventing control frameworks.




# Development guide

This repository contains the documentation and website, generated via Jekyll.

## Problem We're Solving

The financial services industry faces an increasingly complex regulatory landscape where:
- **Each institution interprets and implements their own SDLC controls** — leading to massive duplication of effort
- **No common language exists** — making collaboration and benchmarking difficult across institutions and vendors
- **Significant drift occurs** — as institutions independently evolve their controls, wasting industry-wide resources
- **Vague requirements persist** — controls are either too generic to be actionable or too specific to be reusable

## Our Solution

A **composable, technology-agnostic controls catalog** that provides:
- **Common definitions** for SDLC controls used across financial services
- **Reference implementations** with concrete patterns and examples
- **Shared vocabulary** enabling clear communication between institutions, vendors, and regulators
- **Flexible catalog** where institutions can select applicable controls while maintaining their unique requirements

## Getting Started

### Join the Working Group

- **Bi-weekly calls (every 2 weeks on Mondays)**: Alternating between a regular call and a 3-hour workshop session. See the [FINOS calendar](https://calendar.finos.org/?view=month&date=2026-10-05&q=SDLC) for dates. You can self register to the calls using the links below:
  - [Regular session](https://zoom-lfx.platform.linuxfoundation.org/meeting/96292319760?password=a023f03e-c2aa-46fb-aae3-5d93c9d9664e&invite=true)
  - [Workshop session](https://zoom-lfx.platform.linuxfoundation.org/meeting/94001587941?password=e85f4fbd-7703-4628-b2b0-e454dcf966c8&invite=true)
- **Mailing list**: Send an email to `sdlc-common-controls+subscribe@lists.finos.org`
- **Background**: [Issue #261 — Software Development Lifecycle Common Controls Catalogue Framework](https://github.com/finos/devops-automation/issues/261)
- **Introductory talk from OSFF NY 2025**: [An Open SDLC Controls Framework for Financial Services](https://www.finos.org/hubfs/OSFF%202025%20(Open%20Source%20in%20Finance%20Forum)/OSFF%20New%20York%20NYC%202025/OSFF%20NYC%202025%20Videos/The%20Forge%20Shaping%20New%20Ideas%20Projects/An%20Open%20SDLC%20Controls%20Framework%20for%20Financial%20Services%20-%20Aaron%20Searle%20%26%20Toby%20Weston.mp4)

### How to Contribute

1. **Share your controls** — help us understand how your institution defines and implements SDLC controls
2. **Review definitions** — provide feedback on proposed control definitions
3. **Contribute patterns** — share implementation examples and best practices
4. **Join discussions** — participate in working group meetings and online discussions

## Governance

This project operates under the FINOS DevOps Automation Special Interest Group (SIG) and follows FINOS governance principles.

Meeting minutes are posted as issues in the [DevOps Automation repository](https://github.com/finos/devops-automation/issues) with the prefix "SDLC Framework WG Bi-weekly call".

See [MAINTAINERS.md](MAINTAINERS.md) for the list of participating organisations and maintainers.

## Checking document readiness

The `readiness-check` script validates that risk and mitigation documents meet the criteria required for Working-Group approval and produces a status report.

```sh
make readiness
```

This runs all checks and writes `readiness-report.md` at the repo root with a per-document status table and a risk–mitigation coverage matrix.

For a scoped run, pass `--files`; if you also pass `--report` without a path, the script writes `readiness-report.changed.md` so the full report is not overwritten.

Pull requests also run the readiness check in GitHub Actions for the risk and mitigation documents changed in the PR. That CI job is informative only: it highlights open items for reviewers and publishes the scoped report without blocking merges.

## Versioning cards

Each mitigation and risk can be queried and displayed by its version. Version
history is stored entirely in the repository — there is no database.

Every card carries a single authored field in its front matter:

```yaml
version: "0.1"
```

To **slice a new version**, bump that one line and run:

```sh
make snapshot
```

This materialises an immutable, verbatim copy of the card into the
`docs/_versions` collection (e.g. `docs/_versions/mi-1-v0.2.md`), stamped with
the slice date, the git commit it was taken from, and a content hash. Commit
the new snapshot alongside the card change. Snapshots are generated artefacts —
do not hand-edit them.

On the site, each card shows a **Version History** panel linking to every
sliced version, and each snapshot renders with a banner noting it is a historic
version and linking back to the current one.

A sliced version is frozen. If a card's content changes but its `version` was
not bumped, the stored snapshot no longer matches and CI fails:

```sh
make snapshot-check
```

Resolve it by bumping the `version` and running `make snapshot`, or by
restoring the card. See [VERSIONING.md](VERSIONING.md) for how the process works and
[scripts_docs/README.md](scripts_docs/README.md) for script options.

## Running Jekyll

You will need Ruby and `bundle` installed, then run the site locally using the following.

```sh
cd docs
bundle install
jekyll serve
```

If all goes well, view your freshly minted site at http://127.0.0.1:4000. It should 'hot reload' (Jekyll does its thing) so you can edit and see your changes in the browser.


## Running with Docker

If you don't have Ruby installed, you can use Docker to run the site locally.

```sh
cd docs
docker run --rm -v "$PWD:/srv/jekyll" -p 4000:4000 jekyll/jekyll jekyll serve
```

Then visit http://127.0.0.1:4000 to view the site.


## Governance

This repository follows the Community Specification process. See:

* [GOVERNANCE.md](GOVERNANCE.md)
* [CONTRIBUTING.md](CONTRIBUTING.md)
* [SCOPE.md](SCOPE.md)
* [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)
* [MAINTAINERS.md](MAINTAINERS.md)
* Remaining templates in [governance-documents/](governance-documents/)

## License

This project uses the **Community Specification License 1.0** for its specifications and **Apache License v2** for the underlying source code; you can read more in the [LICENSE](LICENSE) file.
