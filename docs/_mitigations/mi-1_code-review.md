---
sequence: 1
version: "0.1"
title: Code Review
layout: mitigation
doc-status: Draft
type: PREV
phase: CODE
nist-sp-800-53r5_references:
  - cm-3   # CM-3 Configuration Change Control
  - cm-5   # CM-5 Access Restrictions for Change
  - sa-10  # SA-10 Developer Configuration Management
  - sa-11  # SA-11 Developer Testing And Evaluation
  - au-12  # AU-12 Audit Record Generation
eu-dora_references:
  - id: rts-art-16-3
    note: >
      Mandates source code reviews covering both static and dynamic testing,
      with vulnerabilities identified, tracked through an action plan, and
      monitored to closure. The review gate plus SAST integration required by
      this mitigation implements the review; the immutable review records
      provide the evidence.
  - id: rts-art-17-1
    note: >
      Art. 17(1)(b) requires independence between the functions approving a
      change and those requesting or implementing it — the regulatory basis
      for "the author MUST NOT satisfy the human-review requirement for their
      own change". Art. 17(1)(a) and (c) require each change to be verified
      against ICT security requirements, tested, quality-assured and
      documented; the review record bound to the change-set identity
      demonstrates this per change.
  - id: rts-art-16-7
    note: >
      Requires controls protecting the integrity of source code, whether
      developed in-house or supplied by third parties. Technically blocking
      admission to the protected baseline without a valid review outcome is
      the primary integrity control over the baseline.
  - id: dora-art-9-4-e
    note: >
      The parent DORA obligation: documented ICT change management policies
      following a risk-based approach. The deterministic, machine-evaluable
      review policy this mitigation requires is a direct implementation.
uk-fca_references:
  - id: sysc-15a-2
    note: >
      Outcome-based rather than prescriptive: firms must be able to remain
      within impact tolerances for important business services. Mandatory
      review of changes reduces the likelihood that defective or unauthorised
      changes disrupt those services, and retained review records evidence
      this capability in the firm's operational resilience self-assessment.
  - id: pra-ss1-21
    note: >
      The PRA's parallel expectations for dual-regulated firms. Same mapping
      logic as SYSC 15A: this mitigation is evidence of the technology-change
      leg of the firm's resilience capability.
  - id: fca-tech-change
    note: >
      The FCA's closest statement of SDLC-level expectations. It found failed
      technology changes cause roughly a quarter of high-severity incidents,
      and that strong governance, robust pre-deployment assurance and
      frequent, smaller releases correlate with higher change success rates —
      directly supporting risk-based review modes and fast review turnaround
      over batched changes.
ffiec-itbooklets_references:
  - id: dam-2
    note: >
      Section II.B.2 gives code review as the canonical dual-control example:
      "during development, code review involves a second individual to review
      code before it is released to test environments. Segregation of duties
      and dual control help foster security and resilience."
  - id: dam-3
    note: >
      Sections III.A and III.D identify code review as a primary risk
      identification and mitigation control — detecting errors before code
      migrates toward production.
  - id: dam-4
    note: >
      Section IV.D (Secure Development) covers manual and automated code
      review, source code security analyzers, and expects management to
      validate that the code review process meets its needs — the basis for
      maintaining approved automated review tools and configurations.
us-nydfs_references:
  - id: nydfs-500-08
    note: >
      Requires written procedures ensuring secure development practices for
      in-house developed applications, periodically reviewed by the CISO.
      A documented, technically enforced review policy with retained records
      is a central component of those procedures, and supports the covered
      entity's annual certification.
mitigates:
  - ri-8   # Unauthorised Change
  - ri-4   # Vulnerable Software in Production
  - ri-5   # Audit and Compliance Evidence Failure
related_mitigations:
  - mi-8   # Version Control
  - mi-5   # Vulnerability Scanning - SAST
  - mi-10  # Secret Detection
  - mi-14  # Test Evidence Retention
  - mi-15  # Testing Requirements
  - mi-16  # Test Execution and Sign-Off
  - mi-12  # Deployment Gating
---
<!--
Licensed under the Community Specification License 1.0.
See LICENSE and LICENSES/SPECIFICATION-LICENSE.
-->

## Summary

Code changes must complete the review required by the organisation's review policy before they can be merged into a protected branch or other controlled software baseline.

## Description

Code review is a control over the admission of software changes into a controlled baseline. Its primary purpose is to reduce the risk that unauthorised, inappropriate, or insufficiently verified code changes enter the source of record from which software is built, tested, and released. For this control, code changes include configuration, pipeline definitions, prompts, documentation, infrastructure definitions, or other repository artefacts where the organisation's review policy treats them as material to software behaviour, generated output, delivery, or control operation. The reviewable unit is normally a pull request or merge request, but equivalent mechanisms such as patch sets, shelvesets, mainframe change packages, or other attributable change sets can satisfy the same control.

This control does not require every change to receive the same review treatment. At financial services scale, review requirements must be selected through a deterministic, machine-evaluable policy. The policy may require non-deterministic review (such as manual peer review or approved cognitive review engines under NIST SA-11(4)), require non-deterministic review only when policy triggers are met, or permit deterministic automated review (such as static analysis under NIST SA-11(1)) to satisfy the control where the change class and supporting evidence allow it.

Code review complements, but does not replace, automated testing, vulnerability scanning, secret detection, and deployment gating. While deterministic tools evaluate specific, static properties of a change, non-deterministic review provides the essential understanding of logical intent, architectural alignment, and integration safety. This context ensures that the software is maintainable, adheres to design standards, and fails in a safe way.

## Requirements

* The organisation MUST define and maintain a code review policy for reviewable change sets before they are admitted to protected source baselines or equivalent controlled software baselines
* The policy MUST define deterministic, machine-evaluable criteria for selecting the required review mode, including when non-deterministic review is mandatory (such as for critical code under NIST SA-11(4)), when non-deterministic review is required only after policy triggers, and when deterministic automated review (such as static analysis under NIST SA-11(1)) may satisfy the control without non-deterministic involvement
* The policy MUST define which repository artefacts are in scope for review, based on their ability to affect software behaviour, build output, deployment, control operation, or other material SDLC outcomes
* Source control, workflow, or pipeline controls MUST technically block admission to the protected baseline when the required review outcome is absent, expired, revoked, or no longer bound to the current change set
* Review outcomes MUST be bound to an immutable identity for the reviewed content, such as a commit SHA, patch-set hash, shelveset identifier, or equivalent change-set identity
* Review records MUST include the review mode, decision, reviewer identity or approved automated-review tool identity, timestamp, policy inputs sufficient to justify the selected review mode, and links to verification evidence where that evidence is used by the policy
* Where human review is required, the reviewer MUST be eligible under the policy and the author of the change set MUST NOT satisfy the human-review requirement for their own change
* The organisation MUST maintain the approved automated review tools and configurations whose output is permitted to satisfy the review gate
* The policy MUST define when review outcomes are invalidated or require re-evaluation after a material update to the change set
* Emergency bypass of the review gate MUST require named approval, documented justification, retained evidence of the bypass decision, and post-event governance review
* Review records, including automated review outcomes and emergency bypass decisions, MUST be retained in accordance with the organisation's record-retention policy

## Examples & Commentary

* **Risk-based review modes:** A sensitive change, such as a change to authentication, authorisation, cryptographic handling, regulated data processing, financial transaction logic, entitlement checks, deployment pipeline logic, or control evidence generation, may require non-deterministic review by an eligible human reviewer or approved cognitive review engine. A routine change may proceed through deterministic automated review unless required tests fail, a scan finding is introduced, evidence is missing, or the automated review cannot produce a compliant decision.

* **Automated review without non-deterministic involvement:** A low-risk change to a low-criticality component may satisfy the review gate through deterministic automated review where all required verification passes, no sensitive areas are touched, no relevant policy exceptions exist, and the outcome is produced by an approved tool and configuration.

* **Reviewable artefacts beyond executable code:** Documentation, prompts, generated-code instructions, configuration, infrastructure definitions, and policy files may be reviewable where they materially affect software behaviour, generated output, delivery, or control operation. The policy should define these artefacts explicitly rather than assuming only application source files can introduce material change.

* **Policy inputs:** Size, file count, affected modules, dependency graph impact, escaped defects, rollback frequency, incident history, repeated control failures, and exception history can all inform review mode selection. These inputs are imperfect proxies for risk and should be calibrated against the organisation's risk appetite and operational history.

* **Emergency bypass:** During a critical production incident, an authorised approver may permit a change set to enter the protected baseline before the normal review gate is satisfied. The bypass record should identify who approved it, why normal review could not complete, which requirement was bypassed, and what follow-up governance review is required.

* **Automated review oversight:** Where non-deterministic review is automated via approved cognitive review engines, periodic sampling of decisions can help confirm that the approved tools and configurations continue to produce acceptable outcomes. This oversight supports confidence in automated non-deterministic reviews, but does not replace the requirement for deterministic policy and retained review evidence.

## Links

- [NIST Secure Software Development Framework SP 800-218](https://csrc.nist.gov/pubs/sp/800/218/final)
- [NIST SP 800-53r5 SA-11: Developer Testing and Evaluation](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [OWASP Code Review Guide](https://owasp.org/www-project-code-review-guide/)
- [GitHub CODEOWNERS documentation](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-code-owners)
