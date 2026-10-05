---
sequence: 1
version: "1.0"
title: Insider Threat
layout: risk
doc-status: Working-Group-Approved
type: RC
owasp-llm_references:
  - llm02-2025  # LLM02:2025 Sensitive Information Disclosure
nist-ai-600-1_references:
  - 2-4  # 2.4. Data Privacy
  - 2-9  # 2.9. Information Security
ffiec-itbooklets_references:
  - sec-2  # SEC: II Information Security Program Management
  - sec-3  # SEC: III Security Operations
  - ots-2  # OTS: Risk Management
eu-ai-act_references:
  - c3-s2-a10  # III.S2.A10: Data and Data Governance
  - c3-s2-a13  # III.S2.A13: Transparency and Provision of Information to Deployers
  - c5-s2-a53  # V.S2.A53: Obligations for Providers of General-Purpose AI Models
related_risks:
  - ri-2   # Information Leaked to Vector Store
  - ri-23  # Intellectual Property and Copyright
---
## Summary

Authorized personnel (developers, contractors, administrators, or other trusted users) with legitimate access to source code repositories, development environments, production systems, or sensitive data may intentionally or unintentionally compromise the confidentiality, integrity, or availability of software assets. 

## Description

Insider Threat includes risks of malicious code injection, unauthorized data exfiltration, credential misuse, sabotage of build/deployment pipelines, or negligent security practices that expose systems to exploitation. Additionally, insider threat encompasses scenarios where external attackers have compromised the credentials of legitimate users, enabling them to conduct attacks while masquerading as trusted personnel with valid access. The trusted position and technical knowledge of insiders—or attackers leveraging insider credentials—makes detection difficult and potential impact significant.



- **Malicious code injection** - Inserting backdoors, vulnerabilities, or malicious logic into applications or infrastructure
- **Compromised credentials** - Attackers using stolen or phished developer/admin credentials to access systems and data
- **Data exfiltration** - Stealing source code, intellectual property, customer data, or sensitive business information
- **CI/CD pipeline manipulation** - Tampering with build processes, deployment pipelines, or supply chain components to inject malicious code
- **Cloud/infrastructure misconfiguration** - Accidentally or intentionally exposing databases, storage, or services to unauthorized access


### Consequences

The consequences of an insider threat materializing for a financial institution can be severe:

* **Direct Financial Losses:** Fraudulent transactions, theft of funds, unauthorized wire transfers, or manipulation of accounts can result in immediate monetary losses to the institution and its customers.

* **Breach of Data Privacy Regulations:** Unauthorized access to or exfiltration of customer PII can lead to significant fines under regulations like GDPR, CCPA, and GLBA, alongside mandated breach notifications and regulatory scrutiny.

* **Violation of Financial Regulations:** Insider actions compromising system integrity, audit trails, or customer data can breach banking regulations (e.g., SOX, PCI DSS, Basel III) and trigger enforcement actions from regulatory bodies.

* **Reputational Damage:** Public disclosure of insider attacks—particularly those involving customer funds or data—can severely erode customer trust, leading to account closures, deposit flight, and long-term brand damage.

* **Operational Disruption:** Sabotage of critical banking systems, payment processing infrastructure, or core applications can halt operations, impacting customer service and transaction processing capabilities.

* **Loss of Competitive Advantage:** Theft of proprietary trading algorithms, risk models, customer insights, or strategic plans can benefit competitors and undermine market position.

* **Legal Liabilities:** The institution may face lawsuits from affected customers, shareholders, or partners, as well as potential criminal investigations if insider actions involve fraud or data breaches.

---

Does this capture the right scope and tone for your risk register?

## Links

- [FFIEC IT Handbook](https://ithandbook.ffiec.gov/)
- [Scalable Extraction of Training Data from (Production) Language Models](https://arxiv.org/abs/2311.17035)
