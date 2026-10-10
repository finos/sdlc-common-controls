---

## sequence: 13

title: Non-Approved Agentic Processes
layout: risk
doc-status: Draft
type: SEC
eu-ai-act_references:

- c3-s2-a14  # III.S2.A14: Human Oversight (primary)
- c3-s3-a26  # III.S3.A26: Obligations of Deployers of High-Risk AI Systems (primary)
- c3-s2-a12  # III.S2.A12: Record-Keeping (primary)
- c9-s1-a72  # IX.S1.A72: Post-Market Monitoring by Providers (primary)
- c3-s2-a9   # III.S2.A9: Risk Management System (supporting)
- c3-s3-a19  # III.S3.A19: Automatically Generated Logs (supporting)
related_risks:
- ri-8   # Unauthorised Change
- ri-11  # Build Toolchain and Service Supply Chain Compromise
- ri-12  # Business Reputation Risk from Non-Approved Software Version Releases

## Summary

Agentic processes that create code, approve changes, or release software without adequate human oversight, organisational approval, or provenance controls can inject misaligned software into production products, overwhelm human reviewers, and leave the institution unable to monitor, troubleshoot, or demonstrate control over AI-driven SDLC activity—exposing the organisation to integrity failures and non-compliance with the EU AI Act.

## Description

This risk concerns autonomous or semi-autonomous AI agents integrated into the software delivery lifecycle—agents that author code, review or approve pull requests, modify pipelines, or trigger releases—when those agents operate outside approved governance boundaries or without effective human oversight. It is distinct from [RI-11 Build Toolchain and Service Supply Chain Compromise](../ri-11_build-toolchain-and-service-supply-chain-compromise), which concerns compromise of build tools and services by external attackers, and from [RI-8 Unauthorised Change](../ri-8_unauthorised-change), which concerns changes lacking an auditable chain of custody regardless of actor. RI-13 focuses on misaligned *agentic* behaviour: AI systems acting with SDLC privileges in ways that diverge from organisational intent, policy, or regulatory expectations.

The EU AI Act requires that high-risk AI systems be designed and operated with effective human oversight (Article 14), that deployers assign competent oversight, monitor operation, and retain logs (Article 26), and that providers maintain post-market monitoring capable of detecting risks arising from use (Article 72). Record-keeping and automatically generated logs (Articles 12 and 19) are prerequisites for reconstructing agent sessions that contributed to released software. When agentic processes create, approve, or release software without these controls, the organisation cannot demonstrate that human oversight was meaningful, that agent actions were authorised, or that post-market incidents can be traced to specific agent runs.

Challenges:

- **Agentic operations silently injecting misaligned software** — Agents that generate, modify, or promote code into released products without human review or approval gates, introducing behaviour that conflicts with product intent, security policy, or regulatory requirements
- **Overwhelmed human resources unable to oversee every agentic operation** — Volume, velocity, or opacity of agent activity exceeds the capacity of assigned human overseers to meaningfully intervene, reducing Article 14 oversight to a rubber stamp
- **Complex post-market monitoring and troubleshooting of agentic process sessions** — Difficulty reconstructing which agent sessions, prompts, tools, and model versions contributed to a production defect or security incident, undermining post-market monitoring and incident response
- **Missing controls over agentic process provenance** — Absence of durable identity, approval status, and lineage for agent-driven changes, so the organisation cannot attest which agents acted, under what policy, and with what human authorisation

### Consequences

- **Silent injection of misaligned software into production** — Agentic processes can introduce defective, insecure, or strategically misaligned code into released products without a human checkpoint, bypassing the intent of change management and release governance (ri-8, ri-12).
- **Ineffective human oversight under scale** — When agents operate faster than humans can review, oversight becomes nominal rather than effective, placing the organisation out of alignment with EU AI Act Article 14 expectations for human oversight of high-risk AI systems.
- **Impaired post-market monitoring and incident response** — Without being able to locate agents session logs for contributions to the SDLC pipeline, organisations cannot meet Article 72 post-market monitoring obligations or efficiently troubleshoot production failures attributable to agent behaviour.
- **Broken trust and provenance chain** — Missing controls over agent identity, approvals, and artefact lineage leave the institution unable to distinguish human-authored from agent-authored changes, undermining audit evidence and supply-chain integrity claims (ri-11).
- **Regulatory and compliance exposure** — Deployers and providers that cannot demonstrate human oversight, record-keeping, deployer monitoring, and post-market monitoring face enforcement risk under the EU AI Act (notably Articles 14, 26, 12, 19, and 72), in addition to existing financial-sector change-management expectations.
- **Reputational and strategic harm** — Misaligned agent-driven releases that reach customers or markets can damage trust and conflict with product strategy in the same manner as non-approved version releases (ri-12).



