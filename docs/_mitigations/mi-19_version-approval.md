---
sequence: 19
title: Version Release Approval Gating
layout: mitigation
doc-status: Draft
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
  - ri-12  # Business Reputation Risk from Non-Approved Software Version Releases
related_mitigations:
  - mi-12  # Deployment Gating
  - mi-20  # Requirements Approval for Release
  - mi-3   # Software Artifact Provenance
  - mi-1   # Code Review
---

## Summary

Version Release Approval Gating ensures that no version — of a software artifact, an infrastructure-as-code change set, or both — is released to production without satisfying a defined approval process, enforced by designated human approvers, automated policy checks, or a combination of both. It establishes a verifiable, auditable gate at the version level — distinct from per-deployment gates — that confirms the release candidate has satisfied all governance, quality, and risk requirements before any deployment is permitted.

## Description

Deployment gating ([mi-12]({% link _mitigations/mi-12_deployment-gating.md %})) controls whether an individual deployment job may proceed based on technical policy checks. Version Release Approval Gating operates at a higher level: it governs whether a named version has received the organisational approval required to be released at all. A version may pass all automated deployment gates but still require explicit sign-off from a release manager, risk officer, or compliance stakeholder before it can be promoted from a candidate to an approved release.

This distinction is critical in regulated financial services environments where change management frameworks require named human accountability for production releases, not merely automated technical policy satisfaction.

Two complementary approval mechanisms may be used individually or in combination:

**Manual Approval Workflows**
Named approvers — such as a release manager, change advisory board (CAB) member, or risk officer — explicitly authorise a release candidate before it can proceed to any production deployment. The approval is recorded against the specific version, is timestamped and attributed to an identified individual, and must be obtained before any deployment of that version is permitted. Approval workflows may be tiered, requiring different sets of approvers depending on the risk classification of the application or the scope of the change.

**Automated Policy Checks**
Policy-as-code evaluations confirm that the evidence and decisions required for release exist before the version is marked approved: deployment gate criteria satisfied ([mi-12]({% link _mitigations/mi-12_deployment-gating.md %})), mandatory review steps complete ([mi-1]({% link _mitigations/mi-1_code-review.md %})), release-scope requirements agreed ([mi-20]({% link _mitigations/mi-20_requirements-approval.md %})), and the release artefact matched to verified build provenance ([mi-3]({% link _mitigations/mi-3_software-artifact-provenance.md %})). Evaluating the technical posture of the artefact itself — scan findings, test results, remediation timelines — is the domain of deployment gating; the distinguishing output of an automated approval is a durable, attributable approval record that can be used as audit evidence independently of human action.

In either case, the approval state is recorded at the version level in a system of record, and production deployment is technically prevented until the required approval state is confirmed. The approval state is typically one of the conditions a deployment gate ([mi-12]({% link _mitigations/mi-12_deployment-gating.md %})) verifies at each deployment event.

## Requirements

* Every version intended for release to production MUST be subject to a defined approval process before any production deployment is initiated
* Production deployment of a version MUST be technically prevented while the required approval for that version is absent or has been revoked
* The approval process MUST specify which approver roles or automated checks are required, differentiated by application risk classification where appropriate
* Manual approvals MUST be attributed to a named individual, timestamped, and recorded in an auditable system of record
* Automated approval checks MUST produce a structured, machine-readable result that is retained as part of the approval record for that version
* Approval state MUST be bound to an immutable, content-addressable identity for the released version; approval of one version MUST NOT be transferable to another
* Approval records MUST be retained for a period consistent with applicable regulatory requirements and the organisation's record-keeping policy
* The set of required approval checks and approver roles MUST be reviewed at least annually, or following any material change in the application's risk profile, regulatory obligations, or technology stack

## Examples & Commentary

* **CAB-Gated Release:** For a high-criticality payment processing service, the release workflow requires approval from a release manager and a risk officer before the pipeline is permitted to deploy any build to production. The CAB review is documented in the ITSM system against the specific version identity, and the deployment pipeline queries the ITSM API to confirm approval state before executing any production deployment steps.

* **Automated Policy-as-Code Approval:** For a lower-risk internal tooling service, a policy engine evaluates the release candidate against a ruleset: all unit and integration tests passed, no critical CVEs in dependencies, SAST scan completed with no new high findings, and build provenance attestation verified. When all checks pass, the policy engine issues a signed approval record that the deployment pipeline accepts as authorisation to proceed.

* **Tiered Approval by Change Risk:** An organisation classifies changes as standard or significant. Standard changes (low-risk, well-understood) may be approved by automated policy checks alone. Significant changes require a named release manager sign-off in addition to automated checks.

* **Approval Binding to Artefact Digest:** To prevent version substitution attacks or accidental promotion of a different build, approval is recorded against the digest of the release artefact rather than a version label alone. The enforcement point verifies both that the version label matches an approved record and that the artefact digest matches the digest recorded at approval time.

* **Enforcement mechanisms:** Technical prevention of unapproved deployment may be implemented in the deployment pipeline, in the deployment platform's environment protection rules, in an ITSM integration that locks deployment jobs pending change-record approval, or in a policy engine fronting the production environment. The control requires the prevention property, not any particular mechanism.

* **Revocation:** If a vulnerability is discovered in a version that has already been approved but not yet fully deployed, the approval can be revoked in the system of record, and further deployments of that version are rejected until a new approval is granted for a remediated build.

## Links

* [NIST SP 800-53r5 CM-3: Configuration Change Control](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
* [FFIEC IT Handbook — Development, Acquisition, and Maintenance booklet](https://ithandbook.ffiec.gov/it-booklets/development-acquisition-and-maintenance/)
* [GitHub deployment protection rules documentation](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-deployments/managing-environments-for-deployment)
