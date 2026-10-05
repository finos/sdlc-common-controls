---
sequence: 21
version: "0.1"
title: Infrastructure Dependencies
layout: mitigation
doc-status: Draft
type: PREV
phase: RELEASE
nist-sp-800-53r5_references:
  - cm-8   # CM-8 System Component Inventory
  - cm-12  # CM-12 Information Location
  - pm-5   # PM-5 System Inventory
eu-dora_references:
  - id: dora-art-8
    note: >
      Art. 8(1) requires financial entities to identify, classify and
      document all ICT supported business functions, the information assets
      and ICT assets supporting them, and their roles and dependencies,
      with the classification reviewed at least yearly. Art. 8(4) extends
      this to all information and ICT assets including remote sites,
      network resources and hardware, mapping those considered critical
      and the links and interdependencies between assets — the per-system
      infrastructure dependency record this mitigation requires.
uk-fca_references:
  - id: sysc-15a-4
    note: >
      Requires firms to identify and document the people, processes,
      technology, facilities and information necessary to deliver each
      important business service. The technology and facilities legs of
      that mapping are the infrastructure dependency record; retained
      dependency data evidences the mapping in the firm's operational
      resilience self-assessment.
ffiec-itbooklets_references:
  - id: aio-3
    note: >
      The common AIO risk management topics include IT asset management:
      maintaining accurate inventories of hardware, software and
      information assets with assigned ownership and lifecycle (including
      end-of-life) tracking. The per-system dependency record implements
      the inventory expectation from the software system's perspective.
  - id: aio-5
    note: >
      Sets examiner expectations for managing the infrastructure
      components — hardware, networks, operating systems and storage —
      that support business operations. Knowing which software systems
      depend on which components underpins the resilience, upgrade and
      remediation activities the booklet describes.
us-nydfs_references:
  - id: nydfs-500-13
    note: >
      Section 500.13(a) requires written policies producing and
      maintaining a complete, accurate and documented asset inventory of
      information systems — tracking each asset's owner, location,
      classification, support expiration date and recovery time
      objectives — covering hardware, operating systems, applications,
      infrastructure devices, APIs and cloud services. In force since
      November 2025.
mitigates:
  - ri-7  # Configuration Drift
  - ri-4  # Vulnerable Software in Production
  - ri-5  # Audit and Compliance Evidence Failure
chain:
  - Inventory
related_mitigations:
  - mi-9   # Component Inventory
  - mi-17  # Service Dependency Control
---
## Summary

Infrastructure Dependencies provides visibility into the infrastructure resources required to host and operate a software system. By maintaining an accurate inventory of the compute, network, and storage resources a given software system requires, we can better manage the system throughout its lifecycle. This improves operational visibility, supports security and compliance activities, and reduces the risk associated with unmanaged or unknown infrastructure requirements. The primary goal is to ensure that each software system is supported by the appropriate infrastructure and that those infrastructure requirements are understood and governed throughout the software lifecycle.

## Description

Infrastructure Dependencies is the practice of identifying, documenting, and maintaining an up-to-date record of the infrastructure resources required to support the software under management. This includes the compute, network, storage resources and identity and access management on which an application depends, regardless of whether it is deployed on-premises, in cloud environments, or across hybrid infrastructures.

Examples of infrastructure resources include:

* **Compute resources** such as physical servers, virtual machines, containers, Kubernetes clusters, and serverless execution environments.
* **Network resources** such as load balancers, network segments, gateways, DNS services, and connectivity components.
* **Storage resources** such as file systems, object storage, block storage, network-attached storage, relational databases, NoSQL databases, data warehouses, and managed database services.
* **Identity and Access Management** such as customer, employee, and privileged.

Maintaining an accurate list of infrastructure dependencies enables organizations to understand system requirements for deployment, identify ownership and accountability, assess the impact of infrastructure changes, and support operational, security, and compliance activities.

Infrastructure Dependencies enables organizations to appropriately plan and react to changes in underlying infrastructure caused by planned and unplanned outages. It supports software management during platform upgrades, vulnerability remediation efforts, capacity planning, and infrastructure migrations. This control complements Component Inventory and Service Dependency Control by providing visibility into the infrastructure resources that software components and services depend upon at runtime.

## Requirements

* Infrastructure dependencies MUST include the compute, network, storage, and identity resources that support production workloads.
* Compute resources MUST include deployment and hosting information where applicable, such as:
  * Physical servers
  * Virtual machines
  * Containers
  * Kubernetes clusters
  * Serverless execution environments
* Network resources MUST include infrastructure components that provide connectivity, routing, traffic management, or external access where applicable, such as:
  * Load balancers
  * DNS services
  * Network gateways
  * Network segments
* Storage resources MUST include infrastructure used for persistent data storage where applicable, including:
  * File systems
  * Object storage
  * Block storage
  * Relational databases
  * NoSQL databases
  * Data warehouses
* Identity resources MUST include infrastructure used for persistent identity storage, including:
  * Identity stores
  * Certificate vaults
  * Privileged access management stores
* Each infrastructure resource MUST include ownership information to ensure accountability for maintenance, security, and operational support.
* The dependencies MUST identify the infrastructure resources associated with that system, application, or service.
* Infrastructure dependencies records MUST include deployment location information where applicable, such as:
  * On-premises environments
  * Cloud environments
  * Hybrid environments
  * Geographic regions or data centers
* Infrastructure dependencies data MUST be reviewed and updated whenever infrastructure resources associated with the software are added, modified, migrated, or decommissioned.
* Decommissioned infrastructure dependencies MUST be removed from active dependency lists or clearly identified as retired.
* Changes to infrastructure resources MUST be reflected in the dependency list as part of the organization’s change management process.
* Organizations SHOULD endeavor to put practices in place to maintain Infrastructure Dependencies lists aligned with Infrastructure Asset Management Inventories.

## Examples & Commentary

* **Software Deployment**

  A software system is being prepared for production deployment. Infrastructure Dependencies identifies the compute, network, storage, and identity resources required to operate the system, enabling teams to confirm that the appropriate infrastructure has been provisioned and that required dependencies are understood before deployment.

* **Vulnerability Remediation**

  A critical vulnerability is identified in an infrastructure platform or resource used by a software system. Infrastructure Dependencies enables teams to determine whether the software depends on the affected infrastructure, assess the potential impact, and coordinate remediation or migration activities with the appropriate infrastructure owners.

* **Platform Upgrade**

  A software system depends on a Kubernetes cluster that is scheduled for an upgrade. Infrastructure Dependencies provides visibility into the system's reliance on the affected platform, enabling teams to assess compatibility, coordinate testing and deployment activities, and manage the risk of disruption to the software.

* **Infrastructure Migration**

  A software system is being migrated from an on-premises environment to a cloud environment. Infrastructure Dependencies identifies the compute, network, storage, identity, and location requirements supporting the system, enabling teams to plan the target environment and verify that required infrastructure dependencies are preserved during the migration.

* **Operational Incident**

  A software system experiences a production outage caused by the failure of an underlying load balancer or other infrastructure resource. Infrastructure Dependencies enables responders to identify the infrastructure supporting the affected software, determine ownership, understand relevant dependencies, and coordinate recovery activities with the responsible teams.

* **Software Decommissioning**

  A software system is being retired. Infrastructure Dependencies identifies the infrastructure resources associated with the system, enabling teams to determine which compute, network, storage, and identity resources may also be decommissioned or reassigned while reducing the risk of removing infrastructure still required by other systems.

## Links

* [NIST SP 800-53r5 CM-8: System Component Inventory](https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-53r5.pdf)
* [NIST SP 1800-5 — IT Asset Management practice guide](https://csrc.nist.gov/pubs/sp/1800/5/final)
* [FFIEC IT Handbook — Architecture, Infrastructure, and Operations booklet](https://ithandbook.ffiec.gov/it-booklets/architecture-infrastructure-and-operations/)
