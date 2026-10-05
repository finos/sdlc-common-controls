---
sequence: 8
version: "1.0"
title: Version Control
layout: mitigation
doc-status: First-Reading-Approved
type: PREV
phase: CODE
nist-sp-800-53r5_references:
  - id: sa-10
    note: Core control — requires source code and associated documentation to be placed under configuration management.
  - id: cm-2
    note: Version control is the primary mechanism for establishing and maintaining a documented software baseline.
  - id: cm-3
    note: Requires changes to be tracked, reviewed, and approved; version control provides the audit trail of what changed, when, and by whom.
  - id: cm-6
    note: Configuration files such as infrastructure-as-code and application settings must be managed under version control alongside source code.
  - id: cm-9
    note: Requires a formal configuration management plan; use of version control is a core component of that plan.
  - id: si-12
    note: Requires retention of information in accordance with applicable policies; maps to preserving version history for the lifetime of the software.
  - id: au-9
    note: Commit history constitutes an audit trail; this control requires it to be protected from unauthorised modification or deletion.
  - id: ac-2
    note: Governs provisioning, review, and revocation of committer access to the version control system.
  - id: ac-3
    note: Requires access controls to be consistently enforced; maps to branch protection rules and repository permission models.
  - id: ia-5
    note: Covers management of credentials used to authenticate to the version control system, including SSH keys and tokens used for commit signing.
ffiec-itbooklets_references:
  - id: dam-5
    note: The Development section expects source code and software to be managed under version/library control with appropriate change tracking throughout development.
  - id: dam-7
    note: The Maintenance section expects changes to deployed software to be controlled and traceable, which version control underpins.
nist-ssdf_references:
  - id: ps-1
    note: Calls for storing all forms of code in repositories with access control and integrity protection — the SSDF practice most directly mandating version control.
  - id: ps-3
    note: Requires each software release to be archived and protected, supporting retrieval of exactly what was released to production.
iso-iec-27002_references:
  - id: 8-4
    note: Governs managed read/write access to source code, development tools, and software libraries — implemented through version control access controls.
  - id: 8-32
    note: Requires changes to be controlled through a formal change-management process; version control provides the supporting change record.
slsa_references:
  - id: source-track
    note: The Source track expects source to be maintained in version control with a retained, verifiable history — aligning with tamper-evident history and release traceability.
mitigates:
  - ri-1   # Insider Threat
  - ri-8   # Unauthorised Change
---
## Summary
Software and configuration must be stored within an approved version control system.

## Description
Version control is required to maintain a history of all software and configuration changes across all releases. It provides traceability of who made changes and when, establishing the provenance of software over time.

The control establishes verifiable evidence of the state of source code or configuration at the time a release was created. This is important not only for identifying who made changes, but also for understanding what functionality existed at a given point in time — enabling diagnosis of software behaviour weeks, months, or even years after it was originally built, tested, and deployed.

Version control is also integral to ensuring that the software being built and tested is the same software being deployed, by tracking the specific commit or version and providing a reference for traceability.

The integrity of this history is what gives it evidentiary value. The objective is that history cannot be altered or destroyed without detection — not that it can never change. Strict immutability is the simplest way to achieve this, but it is equally acceptable to permit amendment where the system retains a retrievable, attributable record of what changed and why. Unauthorised modification or deletion remains prohibited; only authorised, logged amendment — such as purging a committed secret — is permitted.

## Requirements
In order for a version control system to be effective, it must provide the following properties when used for storing software and configuration.

* **Tamper-Evident History** — The version control system must either preserve history immutably, or provide a retrievable, attributable record of the events and changes that took place, such that the state of the software and configuration at any past point in time can be reconstructed. In either case, history must not be silently or undetectably altered or destroyed.
* **Controlled History Amendment** — Where history is amended for legitimate reasons — for example, to remove committed secrets or personal data that must not persist — the amendment must be an authorised, logged exception. The fact of the amendment, its justification, and the authorising party must be recorded, and the amendment must not be used to obscure the legitimate change record.
* **Release Traceability** — It must be possible to retrieve the exact version (commit or revision) of software and configuration that was released to production, for the applicable retention period.
* **Verified Committers** — The version control system must record the author of each change. Techniques such as commit signing could be employed to demonstrate this.
* **Retention** — History must be maintained for the lifetime of the software or in alignment with applicable retention requirements.
* **Access Control** — The version control system must support access control and should be configured appropriately.

## Examples

**Git** is the most widely adopted distributed version control system and is the de facto standard for software development in regulated and non-regulated environments alike.

* **Tamper-Evident History** — Every commit is identified by a cryptographic SHA hash derived from its content and its parent commits, making silent tampering detectable. Branch protection rules on the default and release branches block force-pushes and history rewrites, so published history cannot be altered; where a secret must be purged, the rewrite is performed as an authorised, logged exception rather than an everyday operation.
* **Verified Committers** — Git supports GPG and SSH commit signing natively. Hosting platforms such as GitHub and GitLab can be configured to require signed commits on protected branches.
* **Access Control** — Enforced at the hosting platform level via branch protection rules, required reviewers, and role-based repository permissions.

**Subversion (SVN)** is a centralised version control system still found in some legacy financial services environments.

* **Tamper-Evident History** — SVN maintains a sequential, server-side revision history. Once committed, revisions cannot be altered without administrator access to the repository backend, and such backend actions are logged and attributable.
* **Verified Committers** — SVN records the authenticated username against each commit. Commit signing is not natively supported; identity relies on server authentication (e.g. LDAP, Kerberos).
* **Access Control** — Controlled server-side via path-based authorisation, allowing fine-grained read/write permissions per directory or branch.

## Links

- [About commit signature verification — GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification/about-commit-signature-verification)
- [Signing commits — GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification/signing-commits)
