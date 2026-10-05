---
sequence: 17
version: "0.1"
title: Service Dependency Control
layout: mitigation
doc-status: Draft
type: PREV
phase: RUNTIME
nist-sp-800-53r5_references:
  - cm-8   # CM-8 System Component Inventory
  - si-4   # SI-4 System Monitoring
mitigates:
  - ri-4   # Vulnerable Software in Production
  - ri-7   # Configuration Drift
  - ri-10  # Dependency and Transitive Supply Chain Compromise
related_mitigations:
  - mi-9   # Component Inventory
  - mi-7   # Vulnerability Scanning - Dependencies
---
## Summary

Service Dependency Mapping provides visibility into how services and external APIs interact across systems and applications. It enables faster incident response, coordinated remediation, and reduced operational risk by maintaining an accurate, up-to-date view of runtime dependencies and their relationships at both service and application levels.

This control complements Component Inventory by extending visibility from artifact-level composition to runtime service and application-level dependency relationships.

## Description

Service Dependency Mapping is the practice of identifying, maintaining, and continuously updating relationships between services, applications, and their dependencies, including internal services and external APIs.

While component inventory focuses on what is included within a software artifact (e.g., libraries and packages), this control focuses on how those components are used and interconnected at runtime across systems. This enables organizations to understand dependencies not only at a technical level, but also at an application and business level.

The mapping provides visibility into upstream and downstream relationships, allowing teams to determine which services and applications are affected when a dependency changes, becomes unavailable, or is found to be vulnerable. It also enables identification of ownership, ensuring that responsible teams can take coordinated action within defined timelines.

This control includes:

- Mapping service-to-service dependencies across systems
- Identifying which services belong to which application or business capability
- Tracking dependencies on external APIs, data providers, and platform services
- Maintaining ownership and team-level responsibility for each service and application
- Understanding upstream and downstream impact relationships
- Keeping dependency mappings aligned with production environments and deployments

Maintaining this mapping ensures that when a failure, vulnerability, or change occurs, its impact can be quickly understood across all affected services and applications, enabling faster and more coordinated responses.

## Requirements

* Service-to-service dependencies MUST be documented and maintained for all production systems
* Dependencies MUST include:
  - Internal services 
  - External APIs and third-party integrations
* Each service MUST be mapped to its corresponding application or business capability
* Ownership information MUST be maintained for each service and application to enable clear accountability during incidents
* Dependency mappings MUST capture upstream and downstream relationships to identify impact propagation
* Dependency data MUST be kept up to date with production deployments and infrastructure changes
* Changes to dependencies (e.g., new integrations, deprecated APIs, version upgrades) MUST be reflected in the mapping as part of the change management process
* Dependency mapping SHOULD be integrated with observability, incident management, or service catalog systems where possible

## Examples & Commentary

* **Vulnerability Propagation:** When a critical vulnerability (e.g., Log4j) is identified in a shared library, dependency mapping enables teams to quickly identify all services using the affected library, all applications those services belong to, and the teams responsible for remediation. This allows coordinated fixes within defined timelines across the organization
* **API Deprecation:** If an external API or third-party provider becomes unavailable or deprecated, dependency mapping allows identification of all dependent services and applications, enabling faster remediation and reducing production incidents
* **Failure Propagation:** In distributed trading or real-time systems, if one service fails, dependency mapping helps identify downstream services and applications impacted, allowing proactive communication and mitigation
* **Platform Upgrades:** During platform or OS upgrades (e.g., encryption or protocol changes), dependency mapping ensures all affected services and applications are identified, preventing runtime failures due to incompatibility
* **Incident Response:** Dependency mapping reduces mean time to restore (MTTR) by enabling responders to quickly understand system relationships instead of relying on incomplete or outdated documentation

## Links

- [NIST SP 800-53r5 CM-8: System Component Inventory](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
- [NIST SP 800-53r5 SI-4: System Monitoring](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
