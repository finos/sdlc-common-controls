---

## sequence: 23

title: Agentic Processes Provenance
layout: mitigation
doc-status: Draft
type: PREV
phase: LIFECYCLE
eu-ai-act_references:

- c3-s2-a12  # III.S2.A12: Record-Keeping (primary)
- c3-s3-a19  # III.S3.A19: Automatically Generated Logs (primary)
- c3-s2-a14  # III.S2.A14: Human Oversight (primary)
- c3-s3-a26  # III.S3.A26: Obligations of Deployers of High-Risk AI Systems (primary)
- c9-s1-a72  # IX.S1.A72: Post-Market Monitoring by Providers (primary)
nist-sp-800-53r5_references:
- au-10  # AU-10 Non-repudiation
- si-7   # SI-7 Software, Firmware, And Information Integrity
- sa-10  # SA-10 Developer Configuration Management
- cm-3   # CM-3 Configuration Change Control
- au-2   # AU-2 Event Logging
mitigates:
- ri-13  # Non-Approved Agentic Processes
related_mitigations:
- mi-3   # Software Artifact Provenance
- mi-2   # Content Addressable Identities
- mi-12  # Deployment Gating
- mi-19  # Version Release Approval Gating

## Summary

Produce signed and immutable provenance evidence for any agentic process that significantly affects a high-risk system's SDLC pipeline—including processes that produce, approve, scan, or test software, or perform release operations—so that all agentic steps can be monitored and gated throughout the pipeline and after release.

## Description

Agentic process provenance answers the questions "which agent acted, using which policies and guidelines, with which tools, who were the involved humans, and what was the result?" for any agentic step that materially affects a high-risk system release. Provenance records are created when the agentic process runs and are linked to the released software so they support in-pipeline control and gating as well as post-market monitoring and post-release audits.

These records are immutable once written and stored in a tamper-evident system that prevents retroactive modification. By binding agentic session evidence to release artefacts (alongside software artefact provenance), agentic process provenance ensures that only software created, checked, and released by approved agentic components operating under corporate policies and guidelines reaches production.

This control complements [MI-3 Software Artifact Provenance]({% link _mitigations/mi-3_software-artifact-provenance.md %}), which establishes chain of custody from source commit through build. MI-23 extends that chain to the agentic actors, contexts, and human oversight that shaped the change before and during release.

## Requirements

- A provenance record MUST be created for every agentic process that significantly affects the content of a high-risk system release (including produce, approve, scan, test, and release operations)
- Provenance records MUST be signed, immutable once written, and stored in a tamper-evident system that prevents retroactive modification
- Provenance MUST be linked to the released software identity in a way that supports both in-pipeline gating and post-market monitoring / post-release audit
- Pipeline and release gates MUST be able to verify that required agentic provenance exists and that the recorded agentic components were approved under corporate policy before promotion to production
- Provenance records MUST answer, at minimum:
  - **Which agentic process operated**, identifying the agent, harness, and models involved
  - **Which context resources** (guidelines, policies, or prompts) were used throughout the agentic session(s)
  - **Which agentic tools were involved** (e.g. skills, MCP tools, and equivalent tool integrations)
  - **How to access the agentic session logs**
  - **Task details** handled by the process (e.g. commit, Jira issue, released version, artifact)
  - **Result of the agentic process**
  - **Human accountable** for the process
  - **Humans that acted as reviewers or co-producers** in the agentic process
  - **Agentic session start and end timestamps** (as required by the EU AI Act)

## Examples & Commentary

- No high-risk system release should proceed to production without provenance for every significant agentic produce, approve, scan, test, or release step that significantly affected that release
- Use a dedicated provenance store or attestation service so agentic records remain independent of any single agent harness or CI/CD system
- Implement deployment and version-approval gates ([MI-12]({% link _mitigations/mi-12_deployment-gating.md %}), [MI-19]({% link _mitigations/mi-19_version-approval.md %})) that verify agentic provenance is present, signed, and bound to approved agent/harness/model identities before release
- Link agentic provenance to artefact digests and version identifiers so post-market monitoring can reconstruct which agent sessions contributed to a released build
- Retain session log references with retention aligned to EU AI Act record-keeping and deployer monitoring obligations
- Periodically audit production releases against agentic provenance to confirm that agent-influenced changes have known, approved origins and named human accountability

