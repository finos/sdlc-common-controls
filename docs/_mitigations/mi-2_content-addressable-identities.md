---
sequence: 2
version: "0.1"
title: Content Addressable Identities
layout: mitigation
doc-status: Draft
type: PREV
phase: META
nist-sp-800-53r5_references:
  - si-7   # SI-7 Software, Firmware, And Information Integrity
  - sa-10  # SA-10 Developer Configuration Management
  - au-10  # AU-10 Non-repudiation
mitigates:
  - ri-1   # Insider Threat
  - ri-5   # Audit and Compliance Evidence Failure
  - ri-7   # Configuration Drift
  - ri-11  # Build Toolchain and Service Supply Chain Compromise
related_mitigations:
  - mi-3   # Software Artifact Provenance
  - mi-8   # Version Control
  - mi-14  # Test Evidence Retention
  - mi-1   # Peer Source Code Review
  - mi-22  # Data Retention and Disposal
---
## Summary

Where a control's evidence refers to the subject it is evidence about, that reference must be a cryptographic hash of the subject's content, so that the binding between evidence and subject cannot be broken after the fact.

## Description

Every control in this catalogue produces evidence about a subject. A peer review ([SDLC-PREV-001]({% link _mitigations/mi-1_code-review.md %})) is evidence about a source revision. A static analysis scan ([SDLC-PREV-005]({% link _mitigations/mi-5_vulnerability-scanning-sast.md %})) is evidence about a state of the codebase. Test evidence ([SDLC-PREV-014]({% link _mitigations/mi-14_test-evidence.md %})) is evidence about a build. A provenance record ([SDLC-PREV-003]({% link _mitigations/mi-3_software-artifact-provenance.md %})) is evidence about an artifact. A release approval ([SDLC-PREV-019]({% link _mitigations/mi-19_version-approval.md %})) is evidence about a version. In every case the evidence is worth no more than the reference that ties it to its subject.

Where that reference is a mutable label — a version tag, a branch name, a filename, a build number, an environment name — the binding can be broken without touching the evidence. The label is reassigned to different content, and the evidence silently becomes a claim about something it was never about. Nothing in the record changes, so nothing appears wrong: the control still shows as having operated, and the evidence it produced no longer means what it says. This is a failure mode that reviewing the evidence cannot detect, because the evidence is not what changed.

Content addressable identification closes this gap by deriving the subject's identity from its content, using a cryptographic hash such as SHA-256. Any change to the content produces a different identity, so a reference by hash cannot be re-pointed. It resolves to exactly the content that was examined, or it does not resolve at all, and either outcome is detectable.

This is why the control is classified as a meta control rather than sitting at a single SDLC phase. It does not prevent or detect a specific undesirable outcome by itself; it is the property that makes the evidence produced by other controls dependable. Build outputs are the most familiar application, but the same requirement applies to source revisions at CODE, to approvals at RELEASE, and to the inventories and evidence stores that span the lifecycle.

Human-readable identifiers — semantic versions, tags, branch names, environment names — remain necessary for navigation, communication, and day-to-day operation. They must not be the reference of record where that reference carries security or compliance weight.

## Requirements

* **Content-Derived Identity** — A subject MUST be identifiable by a cryptographic hash computed over its content, such that any modification to the content produces a different identity.
* **Collision-Resistant Algorithm** — The hash algorithm MUST be SHA-256 or stronger. Algorithms with known practical collision attacks, such as MD5 and SHA-1, MUST NOT be used where the identity carries security or compliance weight.
* **Recorded Algorithm** — The algorithm MUST be recorded alongside the digest, so that an identity remains independently verifiable and can be migrated when an algorithm is deprecated.
* **Fingerprint References in Evidence** — Where a control's record, report, attestation, or approval refers to its subject, it MUST identify that subject by content addressable identity. Human-readable identifiers MAY be recorded alongside, but MUST NOT be the only reference.
* **Verifiable on Use** — A system that acts on a subject by its content addressable identity MUST be able to recompute the hash from the content and confirm it matches before relying on it.
* **Preserved Across Handoffs** — The identity MUST be carried unchanged as a subject moves between systems, pipeline stages, and organisational boundaries. A downstream system MUST NOT substitute a mutable label for the identity it received.

## Examples & Commentary

* **Source revisions are already content addressable:** A Git commit ID is a hash over the tree and the parent chain, so citing a review or scan result by commit SHA rather than by branch name gives that evidence a subject that cannot be reassigned. Referring to `main` instead records only where a branch pointer happened to be at the time. [SDLC-PREV-008]({% link _mitigations/mi-8-version-control.md %}) covers the integrity of the history those identities are drawn from.

* **Container images:** OCI registries support digest references (`registry/app@sha256:...`) alongside mutable tags. Deployment manifests and admission policies should pin by digest — a tag, including a semantic version tag, can be re-pushed to point at different image content, whereas a digest cannot.

* **Packages and dependencies:** Lockfiles are the usual mechanism for holding dependency digests: npm `integrity` fields, `go.sum`, `Cargo.lock`, Maven checksums. A component inventory ([SDLC-PREV-009]({% link _mitigations/mi-9-component-inventory.md %})) that lists only names and versions cannot support the claim that the inventory describes what was actually built.

* **Evidence naming its subject:** A test report should record the digest of the build under test rather than a CI build number. Where the build number is the only identifier, the evidence cannot be re-bound to its subject once the CI system's own records age out under retention policy ([SDLC-PREV-022]({% link _mitigations/mi-22_data-retention.md %})).

* **Where a mutable label is unavoidable:** Operational workflows legitimately need names such as release tags and `latest`. Where they are used, the mapping from label to digest should itself be recorded immutably, so that the mapping in force at a given point in time can be reconstructed rather than inferred. [SDLC-PREV-003]({% link _mitigations/mi-3_software-artifact-provenance.md %}) covers this binding for build artifacts.

* **Verification at boundaries:** Deployment gates and admission controllers ([SDLC-PREV-012]({% link _mitigations/mi-12_deployment-gating.md %})) are the natural enforcement points for the verifiable-on-use property: recompute or confirm the digest before admitting the subject, rather than trusting the reference that accompanied it.

* **Algorithm migration:** Recording the algorithm alongside the digest is what makes migration possible without invalidating historical evidence. Git's ongoing move from SHA-1 to SHA-256 object identities is the clearest example of why the algorithm cannot be left implicit.

## Links

- [FIPS 180-4: Secure Hash Standard](https://csrc.nist.gov/pubs/fips/180-4/upd1/final)
- [NIST SP 800-53r5 SI-7: Software, Firmware, and Information Integrity](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [NIST SP 800-53r5 SA-10: Developer Configuration Management](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [NIST SP 800-53r5 AU-10: Non-repudiation](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [OCI Image Specification: Descriptors and digests](https://github.com/opencontainers/image-spec/blob/main/descriptor.md)
- [Git Internals: Git Objects](https://git-scm.com/book/en/v2/Git-Internals-Git-Objects)
