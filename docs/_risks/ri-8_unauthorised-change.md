---
sequence: 8
version: "0.1"
title: Unauthorised Change
layout: risk
doc-status: Draft
type: SEC
nist-sp-800-53r5_references:
  - cm-3   # CM-3 Configuration Change Control
  - cm-5   # CM-5 Access Restrictions for Change
  - cm-14  # CM-14 Signed Components
  - si-7   # SI-7 Software, Firmware, and Information Integrity
  - au-6   # AU-6 Audit Record Review, Analysis, and Reporting
  - sa-10  # SA-10 Developer Configuration Management
ffiec-itbooklets_references:
  - dam-3  # DAM: III Development and Acquisition
  - sec-2  # SEC: II Information Security Program Management
  - sec-3  # SEC: III Security Operations
related_risks:
  - ri-1   # Insider Threat
---
## Summary

Unauthorised changes to source code, configuration, or build artefacts represent a significant risk to the integrity of software systems. Such changes may be introduced deliberately by malicious actors or inadvertently through inadequate controls, and can result in the deployment of compromised or untested software into production environments.

## Description

Unauthorised change encompasses any modification to software, configuration, or related artefacts that has not been subject to the appropriate review, approval, and tracking processes. This includes changes made directly to production systems, alterations to source code outside of controlled workflows, tampering with build pipelines or deployment artefacts, and modifications to configuration files that bypass formal change management processes.

Unlike insider threat, which focuses on the actor, unauthorised change focuses on the act itself — the introduction of a change that lacks a verifiable, auditable chain of custody. The risk may materialise through a variety of vectors:

- **Direct repository tampering** — modifying source code or history in a version control system without going through a controlled workflow
- **Build pipeline injection** — altering build scripts, dependencies, or artefacts between the point of development and deployment
- **Configuration modification** — changing application or infrastructure configuration outside of version-controlled processes
- **Credential compromise** — an external attacker using stolen credentials to introduce changes while masquerading as a legitimate committer

The consequences of unauthorised change can be severe: malicious code may reach production undetected, compliance audit trails may be broken, and the organisation may be unable to demonstrate the integrity of its software at any given point in time.

## Consequences

* **Integrity compromise** — Untrusted or malicious code may be deployed into production systems, potentially affecting customers, counterparties, or financial markets.
* **Regulatory breach** — Inability to demonstrate controlled change management processes may constitute a breach of FFIEC, SOX, or PCI DSS requirements.
* **Audit trail failure** — Without a verifiable record of who changed what and when, forensic investigation following an incident becomes significantly harder.
* **Operational disruption** — Unreviewed changes introduce a higher probability of defects, misconfigurations, or incompatibilities reaching production.

## Links
