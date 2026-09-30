---
sequence: 12
title: Deployment Gating
layout: mitigation
doc-status: Draft
type: PREV
phase: RELEASE
nist-sp-800-53r5_references:
  - ra-5   # RA-5 Vulnerability Monitoring And Scanning
  - si-2   # SI-2 Flaw Remediation
  - cm-3   # CM-3 Configuration Change Control
  - cm-4   # CM-4 Impact Analyses
  - sa-11  # SA-11 Developer Testing And Evaluation
  - ca-2   # CA-2 Control Assessments
mitigates:
  - ri-4   # Vulnerable Software in Production
  - ri-9   # Environment Breach
related_mitigations:
  - mi-19  # Version Release Approval Gating
  - mi-5   # Vulnerability Scanning - SAST
  - mi-6   # Vulnerability Scanning - DAST
  - mi-7   # Vulnerability Scanning - Dependencies
  - mi-10  # Secret Detection
  - mi-11  # Vulnerability Remediation SLAs
  - mi-15  # Testing Requirements
  - mi-16  # Test Execution and Sign-Off
  - mi-14  # Test Evidence Retention
---

## Summary

Deployment gating blocks promotion of software to the target environment when defined control criteria are not met.

## Description

Deployment gating enforces policy-based decisions at the point of deployment to ensure that only software meeting defined control criteria is promoted to production. Gates evaluate the posture of an artefact against the organisation's defined policies and block deployment when criteria are not met. Without deployment gates, other controls in the catalog are advisory only, and non-compliant software may reach the target environment despite known issues. In regulated financial services environments, deployment gating provides auditable evidence that organisational policy was enforced at every release.

Deployment gating evaluates the current technical posture of an artefact at each deployment event — the same version can pass today and be blocked tomorrow as new findings emerge, scans age, or remediation timelines are breached. Whether the version itself has received organisational approval is governed by version release approval gating ([mi-19]({% link _mitigations/mi-19_version-approval.md %})); that approval state is one of the conditions a deployment gate verifies.

## Requirements

* Deployment gating policies MUST be defined to specify which conditions block deployment, based on the organisation's risk appetite and regulatory requirements
* Gating policies MUST be configurable per application or service to allow organisations to tailor risk thresholds (e.g., stricter policies for internet-facing applications, adjusted thresholds for internal tools)
* Gate evaluation results — including pass/fail status and which checks were evaluated — MUST be retained as part of the deployment record
* Gating policies MUST be reviewed and updated at least annually, or when significant changes to the threat landscape, regulatory requirements, or technology stack occur

## Examples & Commentary

* **Policy Examples:** An organisation might define the following deployment gates: no new critical or high SAST findings; no critical CVEs in dependencies without an approved waiver; DAST scan completed within the last 14 days; no secrets detected in the codebase. The specific policies will vary by organisation and risk appetite
* **Pipeline Enforcement:** Implement gates as required steps in the CI/CD pipeline. For example, a deployment job queries the vulnerability management platform for the artefact's security posture and proceeds only if all gate conditions are satisfied
* **Graduated Policies:** Apply different gate strictness by environment and application criticality. A development environment might allow deployment with medium findings, while production for a customer-facing application blocks on anything high or above
* **Visibility & Feedback:** When a deployment is blocked, provide clear and actionable feedback to the engineering team: which gate failed, what findings caused the failure, and what actions are needed to proceed. Poor feedback loops lead to frustration and incentivise workarounds
* **Relationship to Remediation SLAs:** Deployment gating works hand-in-hand with Remediation SLAs ([mi-11]({% link _mitigations/mi-11_vulnerability-remediation-slas.md %})). SLAs define *when* findings must be remediated; gates enforce that deployments cannot proceed when those timelines are breached. For example, a high-severity SAST finding with a 7-day SLA may not block deployment on day 1, but will block it on day 8 if unresolved

## Links

- [NIST SP 800-53r5 CM-3: Configuration Change Control](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [NIST SP 800-53r5 CM-4: Impact Analyses](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [NIST SP 800-53r5 CA-2: Control Assessments](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [OWASP DevSecOps Guideline](https://owasp.org/www-project-devsecops-guideline/)
- [NIST SSDF SP 800-218](https://csrc.nist.gov/pubs/sp/800/218/final)
- [FFIEC IT Handbook - Information Security](https://ithandbook.ffiec.gov/)
