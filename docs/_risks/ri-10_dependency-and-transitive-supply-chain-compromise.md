---
sequence: 10
version: "0.1"
title: Dependency and Transitive Supply Chain Compromise
layout: risk
doc-status: Draft
type: SEC
nist-sp-800-53r5_references:
  - id: sr-3
    note: Supply Chain Controls and Processes (primary)
  - id: sr-4
    note: Provenance (primary)
  - id: sr-11
    note: Component Authenticity (primary)
  - id: sa-12
    note: Supply Chain Protection (supporting)
  - id: sa-9
    note: External System Services (supporting)
related_risks:
  - ri-4   # Vulnerable Software in Production
  - ri-8   # Unauthorised Change
  - ri-11  # Build Toolchain and Service Supply Chain Compromise
---
## Summary

Malicious, tampered, or subverted software packages — including open source libraries, transitive dependencies, container base images, and language-specific registry artefacts — enter the software development lifecycle and propagate into production, enabling attackers to execute code within the organisation's applications without directly compromising its own systems.

## Description

A single compromised upstream package can fan out across thousands of downstream consumers through transitive dependency chains before the compromise is discovered. Unlike [RI-4 Vulnerable Software in Production](../ri-4_vulnerable-software-in-production), which concerns the presence of known, publicly disclosed vulnerabilities, this risk concerns the deliberate introduction of malicious or tampered code at the point of origin or distribution — code that is designed to evade detection and that may never receive a CVE.

Detection requires visibility into the full transitive dependency graph, not just direct dependencies. Organisations that scan only their declared dependencies miss the vast majority of their actual software supply chain. The attack surface spans every language-specific package registry (npm, PyPI, Maven Central, RubyGems, NuGet, crates.io), container image registries (Docker Hub, public cloud registries), and any upstream source from which components are pulled during build.

- **Compromised upstream packages** — Malicious code injected into widely-used libraries via maintainer account takeover, social engineering of project maintainers, or exploitation of registry authentication weaknesses
- **Transitive dependency poisoning** — Malicious packages introduced deep in the dependency tree where they are pulled in automatically, often without appearing in the organisation's declared dependency manifests or lock files
- **Typosquatting and namespace confusion** — Attackers publishing packages with names that closely resemble legitimate packages, or exploiting misconfigured dependency resolution to substitute malicious internal or public packages
- **Dependency confusion attacks** — Exploitation of package manager resolution logic to cause internal builds to pull attacker-controlled packages from public registries instead of intended private packages
- **Abandoned and end-of-life package takeover** — Unmaintained packages acquired by new maintainers who inject malicious code into subsequent releases, exploiting the trust established by the original maintainer
- **Tampered container base images** — Container base images modified to include backdoors, credential harvesters, or persistent malware, distributed through public or compromised private registries

### Consequences

* **Undetected backdoors in production** — Malicious code embedded in trusted packages can persist in production systems for extended periods, providing attackers with access to sensitive data, internal APIs, and downstream systems without triggering conventional security alerts.
* **Widespread blast radius** — A single compromised package can propagate to every application that depends on it, directly or transitively, potentially affecting the entire application estate simultaneously.
* **Breach of data privacy regulations** — Exfiltration of customer PII or financial data through a compromised dependency can trigger GDPR, CCPA, and GLBA breach notification obligations, significant fines, and regulatory investigations.
* **Supply chain propagation to customers** — Organisations that distribute software built on compromised dependencies propagate the compromise to their own customers and partners, creating cascading trust failures and potential liability.
* **Evasion of conventional security controls** — Malicious code introduced through trusted supply chain channels bypasses perimeter defences, code review, and application-level security controls that assume upstream packages are benign.
* **Costly and disruptive remediation** — Responding to a supply chain compromise requires identifying all affected artefacts across the estate, determining the scope of potential data exposure, rebuilding affected systems from known-good sources, and rotating any credentials that may have been exfiltrated.

## Links
