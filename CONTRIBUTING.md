# Community Specification Contribution Policy 1.0

This document provides the contribution policy for specifications and other documents developed using the Community Specification process in a repository (each a “Working Group”).  Additional or alternate contribution policies may be adopted and documented by the Working Group.

## Requirements

All contributions to this repository are made in agreement with the [Community Specification Contributor License Agreement 1.0](governance-documents/CS_Contributor_License_Agreement.md).

All contributors must be listed in the [PARTICIPANTS.md](PARTICIPANTS.md) file and contributions must pass the EasyCLA checks. See [PARTICIPANTS.md#how-to-enroll-as-a-participant](PARTICIPANTS.md#how-to-enroll-as-a-participant) to enroll as a participant.

## 1.	Contribution Guidelines. 

This Working Group accepts contributions via pull requests. The following section outlines the process for merging contributions to the specification

**1.1.	Issues.**  Issues are used as the primary method for tracking anything to do with this specification Working Group.

**1.1.1.	Issue Types.**  There are three types of issues (each with their own corresponding label):

**1.1.1.1.	Discussion.** These are support or functionality inquiries that we want to have a record of for future reference. Depending on the discussion, these can turn into "Spec Change" issues.

**1.1.1.2.	Proposal.** Used for items that propose a new ideas or functionality that require a larger discussion. This allows for feedback from others before a specification change is actually written. All issues that are proposals should both have a label and an issue title of "Proposal: [the rest of the title]." A proposal can become a "Spec Change" and does not require a milestone.

**1.1.1.3.	Spec Change:** These track specific spec changes and ideas until they are complete. They can evolve from "Proposal" and "Discussion" items, or can be submitted individually depending on the size. Each spec change should be placed into a milestone.

## 2.	Issue Lifecycle.

The issue lifecycle is mainly driven by the Maintainer. All issue types follow the same general lifecycle. Differences are noted below.

**2.1.	Issue Creation.**

**2.2.	Triage.**

o	The Editor in charge of triaging will apply the proper labels for the issue. This includes labels for priority, type, and metadata.

o	(If needed) Clean up the title to succinctly and clearly state the issue. Also ensure that proposals are prefaced with "Proposal".

**2.3.	Discussion.**

o	"Spec Change" issues should be connected to the pull request that resolves it.

o	Whoever is working on a "Spec Change" issue should either assign the issue to themselves or make a comment in the issue saying that they are taking it.

o	"Proposal" and "Discussion" issues should stay open until resolved.

**2.4.	Issue Closure.**

## 3.	How to Contribute a Patch.

The Working Group uses pull requests to track changes. To submit a change to the specification:

**3.1	Fork the Repo, modify the Specification to Address the Issue.**

**3.2.	Submit a Pull Request.** The pull request description must contain the content of the [pull request template](.github/pull_request_template.md), which records agreement with the [Contributor License Agreement](governance-documents/CS_Contributor_License_Agreement.md).

## 4.	Pull Request Workflow.

The next section contains more information on the workflow followed for Pull Requests.

**4.1.	Pull Request Creation.**

o	We welcome pull requests that are currently in progress. They are a great way to keep track of important work that is in-flight, but useful for others to see. If a pull request is a work in progress, it should be prefaced with "WIP: [title]". You should also add the wip label Once the pull request is ready for review, remove "WIP" from the title and label.

o	It is preferred, but not required, to have a pull request tied to a specific issue. There can be circumstances where if it is a quick fix then an issue might be overkill. The details provided in the pull request description would suffice in this case.

**4.2.	Triage**

o	The Editor in charge of triaging will apply the proper labels for the issue. This should include at least a size label, a milestone, and awaiting review once all labels are applied. 

**4.3.	Reviewing/Discussion.**

o	All reviews will be completed using the review tool.

o	A "Comment" review should be used when there are questions about the spec that should be answered, but that don't involve spec changes. This type of review does not count as approval.

o	A "Changes Requested" review indicates that changes to the spec need to be made before they will be merged.

o	Reviewers should update labels as needed (such as needs rebase).

o	When a review is approved, the reviewer should add LGTM as a comment.

o	Final approval is required by a designated Editor. Merging is blocked without this final approval. Editors will factor reviews from all other reviewers into their approval process.

**4.4.	Responsive.** Pull request owner should try to be responsive to comments by answering questions or changing text. Once all comments have been addressed, the pull request is ready to be merged.

**4.5.	Merge or Close.**

o	A pull request should stay open until a Maintainer has marked the pull request as approved.

o	Pull requests can be closed by the author without merging.

o	Pull requests may be closed by a Maintainer if the decision is made that it is not going to be merged.

## 5.	Best Practices.

**5.1.	Enrollment.** All contributors should enroll by submitting a pull request to [PARTICIPANTS.md](PARTICIPANTS.md) accepting the license terms. That will trigger the [EasyCLA](https://easycla.lfx.linuxfoundation.org/) bot to require a Community Specification Contributor License Agreement be signed (either by an individual contributor or by a contributor's employer, which covers the employed contributor) before any contribution.

**5.2.	Use for specifications, not code.** Use the Community Specification License for specification development, not code.

**5.3.	Specification format.** Where appropriate, use the [Community Specification Template](governance-documents/CS_Template.md) to draft your specification.

**5.4.	Separate specifications and source code.** Where possible, separate specifications and source code into different repositories, with the specifications under the Community Specification License and the source code under an OSI-approved open source license.

**5.5.	One specification per repository.** When developing multiple specifications, each individual specification should be in its own repository.

---

# Repository-specific guidance

The sections above are the adopted Community Specification Contribution Policy.
What follows is this Working Group's own practical guidance, as permitted by
"Additional or alternate contribution policies may be adopted and documented by
the Working Group" above.

## Changing a control or risk card

Cards are the Markdown files in `docs/_mitigations/` and `docs/_risks/`. Two
checks run on pull requests that touch them. Neither is currently configured as
a required status check, so a failing check does not by itself stop a merge.

**Readiness check.** Reports whether a card meets the criteria for
Working-Group approval: required sections, cross-references that resolve, and,
for mitigations, at least one regulatory mapping. It always exits 0, so it is
informative only.

```sh
make readiness
```

That writes `readiness-report.md`, which is tracked in git, so it can leave a
modified file in your tree. Restore it before committing, unless updating it is
part of your change.

**Version snapshot check.** Each card declares a `version`, and
`docs/_versions/` holds a frozen copy of the card at that version. Once a
snapshot exists for a card's current version, changing that card's content
makes the frozen copy disagree, and the check fails.

```sh
make snapshot-check
```

Every card currently has a snapshot, so a content change needs a version bump:

1. Change `version:` in the card's front matter, for example `"0.1"` to `"0.2"`.
2. Run `make snapshot` to write the new frozen copy.
3. Commit that copy alongside your card change.

A brand-new card needs a `version` field before it can be sliced.
`python3 scripts/version-snapshot --init` adds one.

Run `make snapshot-check` before pushing. It checks the whole catalogue, so it
can also report cards you did not touch.

Snapshots are generated. Do not hand-edit them.

Both scripts need PyYAML. CI runs them on Python 3.11.

See [VERSIONING.md](VERSIONING.md) for how versioning works and why, and
[README.md](README.md) for the rest of the repository's tooling.
