---
sequence: 7
version: "0.1"
title: Configuration Drift
layout: risk
doc-status: Draft
type: OP
nist-sp-800-53r5_references:
  - id: cm-2
    note: Baseline Configuration (primary)
  - id: cm-3
    note: Configuration Change Control (primary)
  - id: cm-6
    note: Configuration Settings (supporting)
  - id: si-7
    note: Software, Firmware, and Information Integrity (supporting)
related_risks:
  - ri-4   # Vulnerable Software in Production
  - ri-8   # Unauthorised Change
---
## Summary

The actual state of infrastructure, application configuration, or deployment environments diverges from the known, approved, and version-controlled state, creating a growing gap between what the organisation believes is running and what is actually deployed.

## Description

Unlike unauthorised change (ri-8), which concerns individual changes that lack authorisation, configuration drift describes the cumulative divergence of actual state from declared state — often resulting from individually legitimate actions that are never reconciled with the source of truth. This divergence can result from manual changes applied directly to production systems, emergency fixes that are never backported to version control, inconsistent configuration management practices, or failures in infrastructure-as-code pipelines. Changes accumulate silently over time, undermining security controls, complicating incident response, and eroding confidence in the environment's integrity. Configuration drift is also a primary driver of audit and compliance evidence failure (ri-5), because drifted state cannot be reconciled with the version-controlled records that auditors examine.

Not all drift carries the same risk. Security-critical drift — such as changes to firewall rules, encryption settings, or authentication policies — demands immediate detection and remediation. Operational drift — such as divergence in application configuration or feature flags — may be tolerable in the short term but compounds over time. Infrastructure drift — divergence between declared IaC definitions and actual cloud resource state — can silently undo security controls that were verified at deployment time.

- **Manual production changes** — Ad hoc modifications applied directly to production infrastructure or application configuration outside the standard change management process
- **Unreconciled emergency fixes** — Hotfixes or emergency changes applied during incidents that are never backported to the source of truth in version control
- **Infrastructure-as-code divergence** — Drift between declared infrastructure definitions and the actual state of cloud resources, network configurations, or security groups
- **Environment inconsistency** — Development, staging, and production environments falling out of alignment, leading to untested configuration combinations reaching production
- **Untracked configuration drift** — Changes to feature flags, runtime parameters, database schemas, or third-party integrations that are not captured in version control or change records

### Consequences

* **Silent security degradation** — Drifted configurations can inadvertently weaken security controls — opening firewall rules, disabling encryption, relaxing authentication policies, or exposing services to unauthorised networks — without any alert or record.
* **Unpredictable system behaviour** — Applications running with configuration that differs from the tested and approved state may exhibit unexpected behaviour, data processing errors, or transaction failures that are difficult to diagnose.
* **Failed disaster recovery** — Recovery procedures based on version-controlled configuration will restore systems to a state that differs from what was actually running, potentially causing data loss, service failures, or incomplete recovery.
* **Regulatory non-compliance** — Regulators expect that organisations can demonstrate the current state of their systems and that changes are controlled and auditable. Configuration drift directly undermines this expectation and can trigger findings under SOX Section 404, PCI DSS Requirement 1, DORA Article 9, and FFIEC examination procedures.
* **Complicated incident response** — When the actual state of systems is unknown or differs from documentation, incident responders cannot reliably assess the scope of a compromise or determine whether specific controls were in place at the time of an incident.
* **Increased operational risk** — Teams making changes based on stale documentation or incorrect assumptions about the current environment are more likely to cause outages, introduce conflicts, or break dependent services.
* **Erosion of trust in automation** — When manual changes routinely override automated configuration management, teams lose confidence in infrastructure-as-code processes, leading to a cycle of increasing manual intervention and further drift.
* **Loss of audit evidence** — When actual state diverges from version-controlled declarations, the organisation cannot demonstrate to auditors what was running at a given point in time, directly contributing to audit and compliance evidence failure (ri-5).
* **Control evasion through cumulative drift** — Individual drifts may each appear minor, but their cumulative effect can disable or weaken security controls in ways that no single change review would have approved.
* **Incident forensics obscuration** — When the actual state of systems at the time of an incident is unknown, forensic investigators cannot determine what was running, what was exposed, or what the attacker had access to, significantly impairing incident response effectiveness.

## Links
