---
layout: page
title: "Using the Catalog"
subtitle: "How to read, adopt, and cite the catalog's risks and controls"
draft: true
---

The SDLC Common Controls Catalog is a shared reference. Institutions, vendors and
auditors can point at the same control definitions instead of each writing their
own. This page explains how to read a card, how to adopt controls, and how to cite
a specific version so your reference stays accurate as the catalog evolves.

## What is in the catalog

The catalog has two kinds of card:

- **Mitigations** (controls) describe what an organisation does to reduce risk,
  stated as testable requirements. These are what you adopt, implement and cite.
- **Risks** describe what can go wrong in the software delivery lifecycle and the
  consequences for a regulated institution. They are supporting material: they
  explain *why* the controls exist and help you decide which controls apply to you.

Each mitigation lists the risks it mitigates, related mitigations, and mappings to
regulatory guidance and industry standards such as DORA, the FCA/PRA operational
resilience rules, FFIEC, NYDFS, NIST SP 800-53 and NIST SSDF.

## Reading a control

Every mitigation follows the same structure:

| Section | Purpose |
|---|---|
| **Summary** | One-sentence statement of the control. |
| **Description** | What the control is for, what it covers, and how it relates to other controls. |
| **Requirements** | The normative part: what an organisation must do to claim it implements the control. |
| **Examples & Commentary** | Non-normative illustrations of how the control can be met. |
| **Links** | Further reading. |

Only the **Requirements** section is normative. Examples and commentary help with
interpretation but do not add obligations.

### Requirement keywords

The key words **MUST**, **MUST NOT**, **SHOULD**, **SHOULD NOT** and **MAY** in
requirements are to be interpreted as described in
[BCP 14 (RFC 2119, RFC 8174)](https://www.rfc-editor.org/info/bcp14) when, and only
when, they appear in all capitals:

- **MUST / MUST NOT**: required to claim the control is implemented.
- **SHOULD / SHOULD NOT**: expected unless there is a documented, justified reason
  to deviate.
- **MAY**: genuinely optional.

## Identifiers

Each card has a stable identifier, shown at the top of its page:

- Mitigations: `SDLC-<classification>-<number>`, for example `SDLC-PREV-008`
  (Preventative control 8, *Version Control*).
- Risks: `SDLC-<classification>-<number>`, for example `SDLC-RC-001`
  (Regulatory and Compliance risk 1, *Insider Threat*).

Use the control's identifier, together with a version, whenever you refer to it.

## Document status

Every card carries a status that tells you how mature it is:

<dl class="row">
{% for status in site.document_status %}
  <dt class="col-sm-4">{{ status.name }}</dt>
  <dd class="col-sm-8">{{ status.description }}</dd>
{% endfor %}
</dl>

Only cards at **Working-Group-Approved** are agreed by the working group. Earlier
statuses are published for review and feedback and may change significantly. Avoid
building firm commitments on them.

## Versions

Each card has a version, shown as a badge next to its title (for example
**v1.0**). When a card changes materially, the working group publishes a new
version. Every published version stays available, unchanged, at its own address.
You can see them in the **Version History** panel on each card.

As a rule of thumb:

- **0.x** versions are pre-approval drafts.
- **1.0** is the first working-group-approved version.
- Later versions refine an approved control. If requirements change, check what is
  new before moving your references to it.

## Citing a control

The live page for a control always shows the *latest* text, so a link to it can
change meaning over time. To pin a reference, cite the **identifier, version and
snapshot link**. Every control page has a **Cite This Version** panel with a
ready-to-copy reference, for example:

```
SDLC-PREV-008 v1.0, Version Control. FINOS SDLC Common Controls Catalog. {{ site.public_url }}/versions/mi-8-v1.0.html
```

The snapshot link always shows exactly the text that was published as that version.
This makes it suitable for policies, control mappings, audit evidence and
regulatory responses, where you need to show what you relied on at the time.

Cite controls rather than risks. Risks explain the context for a control, but your
obligations come from the control's requirements.

When a new version is published:

1. Open the new version from the control's **Version History** panel and compare its
   requirements with the version you cite.
2. Decide whether your implementation already meets the new version.
3. Update your reference once you have adopted it. Until then, your existing
   citation stays valid and continues to point at the text you assessed against.

## Adopting controls

The catalog is composable. You do not have to adopt everything.

1. **Select** the controls relevant to your organisation. The risks and the phase
   filters on the [catalog]({{ site.baseurl }}/) are a good starting point.
2. **Map** each selected control to your internal control framework, recording the
   catalog identifier and version against your own control ID.
3. **Implement** against the **Requirements** section. Use Examples & Commentary for
   guidance.
4. **Evidence** each requirement. Many requirements specify the records to retain.
5. **Trace** to regulation using the regulatory references on each card, which show
   how a control supports specific obligations. These mappings are guidance, not
   legal advice. Confirm them against your own regulatory interpretation.

## Licence

The specifications are published under the
[Community Specification License 1.0](https://github.com/finos/sdlc-common-controls/blob/main/LICENSE),
so you can reuse and adapt the control text within your organisation. Please keep
the catalog identifier and version so readers can trace back to the source.

## Feedback

If a control is unclear, does not fit your environment, or you have an
implementation pattern to share, open an issue or pull request on
[GitHub](https://github.com/finos/sdlc-common-controls), or join the working group.
See the [README](https://github.com/finos/sdlc-common-controls#getting-started) for details.

## Tell us you use the catalog

If your organisation has adopted or mapped to any of these controls, we would like
to hear from you. Knowing who uses the catalog helps the working group prioritise
its work, and, with your permission, we would like to list adopters on this site.

Let us know in either of these ways:

- **Raise an issue** on [GitHub](https://github.com/finos/sdlc-common-controls/issues/new?title=Adoption%3A%20)
  titled "Adoption: *your organisation*".
- **Email the working group** at
  [sdlc-common-controls@lists.finos.org](mailto:sdlc-common-controls@lists.finos.org?subject=Adoption%3A%20).
  To join the mailing list, send an email to
  [sdlc-common-controls+subscribe@lists.finos.org](mailto:sdlc-common-controls+subscribe@lists.finos.org).

Please include:

- your organisation's name;
- which controls you use, with their versions (for example, SDLC-PREV-008 v1.0);
- how you use them, for example adopted as written, mapped to an internal
  framework, or used as a reference;
- whether we may name your organisation on this site.

A short note is fine. You do not need to share any detail of your implementation.
