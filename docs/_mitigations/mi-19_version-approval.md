---
sequence: 19
version: "1.0"
title: Release Approval
layout: mitigation
doc-status: Working-Group-Approved
type: PREV
phase: RELEASE
nist-sp-800-53r5_references:
  - cm-3   # CM-3 Configuration Change Control
  - cm-5   # CM-5 Access Restrictions for Change
  - ca-6   # CA-6 Authorization
eu-dora_references:
  - id: dora-art-9-4-e
    note: >
      The parent DORA obligation: documented ICT change management policies
      following a risk-based approach. A defined, version-level approval
      process with named accountability is a direct implementation of that
      policy for software releases.
  - id: rts-art-16-2
    note: >
      Requires ICT systems to be tested and approved before their first use
      and before changes are deployed to the production environment. The
      version-level approval gate is the point at which that approval is
      granted and recorded ahead of any production deployment.
  - id: rts-art-17-1
    note: >
      Art. 17(1)(b) requires independence between the functions approving a
      change and those requesting or implementing it — the basis for
      requiring defined approver roles distinct from the delivery team.
      Art. 17(1) also requires changes to be documented and verified before
      production; the approval record bound to the version identity
      evidences this per release.
uk-fca_references:
  - id: sysc-15a-2
    note: >
      Outcome-based rather than prescriptive: firms must be able to remain
      within impact tolerances for important business services. Gating
      production releases on explicit approval reduces the likelihood that
      unauthorised or unready versions disrupt those services, and the
      retained approval records evidence this capability in the firm's
      operational resilience self-assessment.
  - id: pra-ss1-21
    note: >
      The PRA's parallel expectations for dual-regulated firms. Same mapping
      logic as SYSC 15A: version-level release approval is evidence of the
      technology-change leg of the firm's resilience capability.
  - id: fca-tech-change
    note: >
      The FCA's multi-firm review found failed technology changes cause
      roughly a quarter of high-severity incidents, and that strong
      governance and robust pre-deployment assurance correlate with higher
      change success rates — directly supporting a defined, risk-tiered
      approval gate at the version level.
ffiec-itbooklets_references:
  - id: dam-2
    note: >
      Governance of development, acquisition, and maintenance: management
      oversight, defined roles and responsibilities, and accountability for
      approving what is delivered into production. Named approver roles with
      recorded, attributable decisions implement this expectation at the
      version level.
  - id: dam-7
    note: >
      Maintenance covers change management over operational systems,
      including expectations that changes are authorised before
      implementation and that change records are retained. The version-level
      approval state, bound to an immutable version identity, is the
      authorisation record for each release.
mitigates:
  - ri-12  # Business Reputation Risk from Non-Approved Releases
related_mitigations:
  - mi-12  # Deployment Gating
  - mi-20  # Requirements Approval for Release
  - mi-3   # Software Artifact Provenance
  - mi-1   # Code Review
---

### Summary

Release Approval decides whether a named version has the organisational approval to be released at all.

### Description

Where a system requires an explicit decision before release, for legal, regulatory, timing or risk reasons , release approval gates record that decision against a specific version, following the organisation's change management policy.

The decision can be made by named people, by a policy engine acting under an accountable individual, or by both. The organisation chooses which, based on the risk of the change. Either way, there must be a clear record of who or what approved which version, and under what rules.

### Requirement

1. There MUST be a record of the release approval that includes the named approvers and the specific versions or defined changes to the target environment. 
2. Release approval SHOULD be time bound
3. Environment changes MUST be technically prevented while the required approval is absent or has been revoked.
4. The approval process MUST define the preconditions, approver roles and checks required.
5. Automated approvals MUST be attributed to an identified policy engine, a policy version and an accountable individual.
6. Approval SHOULD be bound to an immutable, content-addressable identity for the released version; approval of one version MUST NOT be transferable to another.
7. An approver MUST NOT be an author of the change


### Examples and commentary

**CAB-gated release (high tier).** For a high-criticality payment processing service, the release workflow requires approval from a release manager and a risk officer before the pipeline may deploy any build to production. The CAB review is documented in the ITSM system against the specific version identity, and the deployment pipeline queries the ITSM API to confirm approval state before executing any production deployment steps.
**Automated approval (low tier).** For a lower-risk internal tooling service, a policy engine confirms that the candidate met its deployment gate criteria (mi-12), that code review is complete (mi-1) and that build provenance is verified (mi-3). When all preconditions pass, the policy engine issues a signed approval record carrying its identity and policy version, which the deployment pipeline accepts as authorisation to proceed.
**Tiered approval by change risk.** An organisation classifies changes as standard or significant. Standard changes (low-risk, well-understood) may be approved by automated policy checks alone. Significant changes require a named release manager sign-off in addition to automated checks.
**Agent-influenced change (medium tier).** A release includes commits produced by an AI coding agent. The policy engine confirms that an agentic provenance record (SDLC-PREV-023) exists for each agent-influenced commit and that each commit was reviewed by a named individual. A named release manager then approves the version. 
**Approval binding to artefact digest.** To prevent version substitution attacks or accidental promotion of a different build, approval is recorded against the digest of the release artefact rather than a version label alone. The enforcement point verifies both that the version label matches an approved record and that the artefact digest matches the digest recorded at approval time.
**Enforcement mechanisms.** Technical prevention of unapproved deployment may be implemented in the deployment pipeline, in the deployment platform's environment protection rules, in an ITSM integration that locks deployment jobs pending change-record approval, or in a policy engine fronting the production environment. The control requires the prevention property, not any particular mechanism.
**Revocation.** If a vulnerability is discovered in a version that has been approved but not yet fully deployed, the approval can be revoked in the system of record. Further deployments of that version are rejected until a new approval is granted for a remediated build.

## Links

* [NIST SP 800-53r5 CM-3: Configuration Change Control](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
* [FFIEC IT Handbook — Development, Acquisition, and Maintenance booklet](https://ithandbook.ffiec.gov/it-booklets/development-acquisition-and-maintenance/)
* [GitHub deployment protection rules documentation](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-deployments/managing-environments-for-deployment)
