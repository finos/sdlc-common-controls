---
sequence: 3
version: "0.1"
title: Credential and Secret Exposure
layout: risk
doc-status: Draft
type: SEC
nist-sp-800-53r5_references:
  - id: ia-5
    note: Authenticator Management (primary)
  - id: sc-12
    note: Cryptographic Key Establishment and Management (primary)
  - id: sc-28
    note: Protection of Information at Rest (supporting)
related_risks:
  - ri-1   # Insider Threat
  - ri-6   # Unauthorised System Access
---
## Summary

Sensitive authentication material — such as API keys, database passwords, service account tokens, encryption keys, or certificates — is inadvertently or deliberately exposed in locations where it can be accessed by unauthorised parties, enabling compromise of production systems, customer data, and internal infrastructure.

## Description

Credential exposure commonly occurs through secrets committed to version control repositories, hardcoded credentials in application code, secrets leaked in CI/CD logs and artefacts, or credentials stored in insufficiently protected configuration management systems. Once exposed, credentials can be harvested by attackers and used to gain unauthorised access to production systems, customer data, and internal infrastructure. The exposure itself may go undetected for extended periods, particularly when secrets persist in version control history after removal from the working tree.

- **Secrets committed to source control** — API keys, passwords, or tokens checked into Git repositories where they persist in history even after removal from the working tree
- **Hardcoded credentials in application code** — Database connection strings, service account passwords, or encryption keys embedded directly in source files rather than injected at runtime
- **CI/CD log leakage** — Build and deployment pipelines inadvertently printing secrets to log output, making them visible to anyone with access to pipeline logs
- **Secrets embedded in infrastructure-as-code and CI/CD configuration** — Credentials hardcoded in Terraform state files, Ansible playbooks and variable files, CloudFormation/SAM templates, Helm values files, Kubernetes manifests, Dockerfiles, or CI/CD pipeline definitions (`.github/workflows`, `.gitlab-ci.yml`, Jenkinsfile) where they are committed to version control alongside the infrastructure they configure
- **Insecure secret storage** — Credentials stored in plaintext configuration files, environment variables without encryption, shared documents, or messaging platforms
- **Overprivileged service credentials** — Service accounts or API keys granted excessive permissions, amplifying the blast radius if the credential is compromised

### Consequences

* **Unauthorised access to production systems** — Exposed credentials provide attackers with direct access to databases, APIs, cloud infrastructure, and internal services, enabling data theft, transaction manipulation, or system compromise.
* **Customer data breach** — Compromised database credentials or API keys can be used to exfiltrate customer PII, account details, and financial records, triggering breach notification obligations under GDPR, CCPA, and GLBA.
* **CI/CD pipeline compromise** — Leaked pipeline credentials enable attackers to tamper with build and deployment processes, injecting malicious code into artefacts destined for production.
* **Regulatory penalties** — Inadequate secrets management violates requirements under PCI DSS Requirement 8, SOX Section 404, DORA Article 9, and FFIEC supervisory guidance, exposing the institution to fines, enforcement actions, and mandated remediation programs.
* **Reputational damage** — Public disclosure that customer-facing systems were compromised through leaked credentials — particularly if customer funds or data were affected — severely damages institutional trust.
* **Costly remediation** — Responding to credential exposure requires emergency rotation of all potentially affected secrets, forensic investigation to determine the scope of compromise, and potential rebuilding of affected systems — all under significant time pressure.

## Links
