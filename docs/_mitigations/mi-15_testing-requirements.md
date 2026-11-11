---
sequence: 15
version: "0.3"
title: Testing Requirements
layout: mitigation
doc-status: First-Reading-Approved
type: PREV
phase: LIFECYCLE
chain:
  - testing-assurance
nist-sp-800-53r5_references:
  - sa-11  # SA-11 Developer Testing And Evaluation
  - sa-15  # SA-15 Development Process, Standards, And Tools
  - cm-4   # CM-4 Impact Analyses
mitigates:
  - ri-4   # Vulnerable Software in Production
  - ri-5   # Audit and Compliance Evidence Failure
related_mitigations:
  - mi-16  # Test Execution and Sign-Off
  - mi-14  # Test Evidence Retention
  - mi-12  # Deployment Gating
  - mi-5   # Vulnerability Scanning - SAST
  - mi-6   # Vulnerability Scanning - DAST
  - mi-7   # Vulnerability Scanning - Dependencies
---
## Summary

A testing policy must be defined that specifies the categories and scope of testing required before any change is released to production, covering the quality, functionality and resilience of the software, proportionate to the risk profile of the change.

## Description

This control establishes the policy layer of the organisation's testing posture: what types of testing must be performed and when. It does not govern whether the testing was actually executed ([SDLC-PREV-016]({% link _mitigations/mi-16_test-execution.md %})), whether it was enforced mechanically ([SDLC-PREV-012]({% link _mitigations/mi-12_deployment-gating.md %})), or whether the results were retained ([SDLC-PREV-014]({% link _mitigations/mi-14_test-evidence.md %})). Its sole concern is that the organisation has defined, documented, and maintains a testing policy that maps required testing activities to change types.

The testing policy definition defines what degree of testing applies to different change types. This is particularly critical for manual testing due to its overall expense, and you may wish to define when it is or is not appropriate to run each suite of tests. Without an explicit testing policy, testing decisions are left to individual judgement and vary across teams, repositories, and release cycles. This creates inconsistency, makes audit response difficult, and means the organisation cannot demonstrate that its testing expectations were defined in advance rather than rationalised after the fact. In regulated financial services environments, examiners expect a documented testing standard that exists independently of any individual release.

The policy must address the full spectrum of change types — from low-risk configuration updates to changes to critical functionality — and define what testing is required for each. It should be specific enough to be enforceable and auditable, but not so prescriptive that it cannot accommodate the diversity of technologies and delivery patterns within the organisation.

## Requirements

* A testing policy MUST be defined that specifies the categories of testing required for each change classification (e.g., patch, minor feature, major release, infrastructure change, security-sensitive change)
* The policy MUST define a minimum testing baseline that applies to all changes regardless of classification; this baseline MUST include at minimum regression testing to confirm that existing behaviour is not broken
* The policy MUST require that the testing applied to a change is appropriate to the risk profile of that change
* The policy SHOULD include targeted security testing, in addition to functional testing, for changes to security-sensitive components such as authentication, authorisation, session management, cryptographic operations, and data handling
* Changes to critical code paths that have been identified as being particularly sensitive to the application SHOULD require additional testing
* The policy SHOULD contain appropriate testing thresholds for the criticality of the application being produced
* The policy MUST specify exit criteria that define what constitutes a passing test outcome for each change classification, including acceptable treatment of pre-existing known failures

## Examples & Commentary

* **Change Classification:** Define a simple taxonomy of change types and map required testing to each. For example: a dependency patch may require automated unit and integration tests; a new customer-facing feature may additionally require functional UAT; a change to a critical service such as payment processing may also require performance and resilience testing, such as load or failover tests, before release
* **Testing Thresholds:** Set thresholds in proportion to the criticality of each application — a payment processing service may warrant a higher bar than an internal tool. Document the rationale for the thresholds chosen
* **Exit Criteria:** Define release readiness criteria before testing begins, not after. Criteria should specify, for example, that no new test failures are introduced by the change without documented acceptance, and that the testing thresholds set for the application are met. Pre-existing failures that are known, tracked, and unrelated to the change may be accepted without blocking release, provided they are documented. Vague or unwritten criteria are easily gamed and do not provide meaningful assurance
* **Relationship to Other Controls:** This control defines what testing is required. [SDLC-PREV-016]({% link _mitigations/mi-16_test-execution.md %}) (Test Execution and Sign-Off) ensures that testing is carried out and signed off for each release. [SDLC-PREV-014]({% link _mitigations/mi-14_test-evidence.md %}) (Test Evidence Retention) ensures the records of completed testing are preserved. All three are required for a complete testing assurance posture

## Links

- [NIST SP 800-53r5 SA-11: Developer Testing and Evaluation](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [NIST SP 800-53r5 SA-15: Development Process, Standards, and Tools](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [NIST SSDF SP 800-218](https://csrc.nist.gov/pubs/sp/800/218/final)
- [OWASP DevSecOps Guideline](https://owasp.org/www-project-devsecops-guideline/)
- [FFIEC IT Handbook - Information Security](https://ithandbook.ffiec.gov/)
