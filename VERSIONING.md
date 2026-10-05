# Card Versioning — How It Works

This document explains how version control for cards (mitigations and risks)
works in this repository, why it is built the way it is, and the day-to-day
workflow for slicing and viewing versions.

It is written for contributors and maintainers. If you just want the commands,
jump to [Everyday workflow](#everyday-workflow).

---

## What problem this solves

Every mitigation and risk is a "card" — a Markdown file with YAML front matter
in a Jekyll collection (`docs/_mitigations/`, `docs/_risks/`). As the catalog
matures, the wording of a control changes. We need to be able to **query and
display a card at a specific version**, and to keep a durable, auditable
history of what each control said when a version was cut.

The constraints:

- **No database.** Everything must live inside the repository.
- **Low manual effort.** Hand-copying files on every change is error-prone.
- **Static-site friendly.** GitHub Pages builds the site with Jekyll and cannot
  run arbitrary tooling or read git history at build time.

## The approach, in one picture

```
docs/_mitigations/mi-1_code-review.md        <- the live, current card
    front matter:  version: "0.2"                (you bump this one line)

          │  make snapshot
          ▼

docs/_versions/mi-1-v0.1.md                   <- frozen snapshot of v0.1
docs/_versions/mi-1-v0.2.md                   <- frozen snapshot of v0.2
    front matter adds: ref, snapshot_version,
                       snapshot_date, snapshot_commit, source_sha256
```

Each card declares its **current** version in one front-matter field:

```yaml
version: "0.2"
```

When you want to freeze ("slice") a version, you run `make snapshot`. The
`scripts/version-snapshot` tool writes a **verbatim, immutable copy** of the
card into the `docs/_versions` collection, named `<id>-v<version>.md`
(e.g. `mi-1-v0.2.md`). Each snapshot is stamped with:

| Field              | Meaning                                              |
|--------------------|------------------------------------------------------|
| `ref`              | The card id, e.g. `mi-1`                             |
| `ref_collection`   | `mitigations` or `risks`                            |
| `source_layout`    | The card's original layout                          |
| `snapshot_version` | The version this snapshot freezes                   |
| `snapshot_date`    | The date it was sliced                              |
| `snapshot_commit`  | The git commit it was sliced from                   |
| `source_sha256`    | A hash of the card's content when sliced            |

Because snapshots are plain Markdown committed to the repo, they are diffable in
pull requests, rendered statically by Jekyll, and need no database. Git remains
the underlying source of truth — each snapshot records the commit it came from.

## Why not just use git history or tags?

Git already stores every change, so why materialise copies?

- **The static build can't see git.** GitHub Pages runs Jekyll against a working
  tree, not the git history. A page that needs to render "v0.1" must have v0.1
  present as a file.
- **Git history is noisy.** Typo fixes, formatting, and merge commits are not
  "versions." A version is a deliberate, curatorial cut — not every commit.
- **Versions should be intentional.** Bumping `version:` is an explicit decision
  by an author/working group, reviewable in a PR, rather than an accident of
  commit timing.

So we keep git as the backing store (we record the commit SHA in every
snapshot) but publish intentional, named versions as static pages.

## Immutability: sliced versions are frozen

Once a version is sliced, its snapshot must not change. The tool enforces this:

- `source_sha256` records the card's content at slice time.
- `scripts/version-snapshot --check` recomputes the hash for each card's current
  version and compares it to the stored snapshot.
- If a card's content changed but its `version` was **not** bumped, the check
  fails with a clear message.

This runs in CI (`.github/workflows/version-snapshot-check.yml`) on every pull
request that touches a card, a snapshot, or the script. The fix is always one of:

1. **Bump the version** (`version: "0.2"`) and run `make snapshot` — if the
   change is a genuine new version; or
2. **Restore the card** — if the change was accidental.

> The hash is computed from the *parsed* front matter plus the body, so
> comment-only or whitespace-only reformatting of the front matter does not
> count as content drift.

## What you see on the site

- **Live card pages** (mitigation/risk) show a `v0.2` badge next to the title
  and a **Version History** panel listing every sliced version, newest first,
  with the current one marked.
- **Snapshot pages** (`/versions/mi-1-v0.1`) render the frozen content with a
  banner explaining you are viewing a historic (or the latest) version, the
  date and commit it was sliced from, and a link back to the current version.

---

## Everyday workflow

### 1. Edit a card as normal

Edit `docs/_mitigations/mi-1_code-review.md` (or any risk).

Once a snapshot exists for the card's current version, that version is frozen:
changing the card's content requires the bump in step 2. See
[Immutability](#immutability-sliced-versions-are-frozen) for what counts as a
content change.

### 2. When you want to freeze a version, bump it

Change the one line in the card's front matter:

```yaml
version: "0.2"     # was "0.1"
```

### 3. Slice the snapshot

```sh
make snapshot
```

This writes `docs/_versions/mi-1-v0.2.md`. Commit it together with your card
change.

### 4. Verify (optional locally; automatic in CI)

```sh
make snapshot-check
```

`OK — N cards, all versions snapshotted and unchanged` means you are good.

### Seeding a brand-new card

New cards need a `version` field. Add it by hand, or let the tool add a default
(`0.1`) to any card missing one:

```sh
./scripts/version-snapshot --init          # default 0.1
./scripts/version-snapshot --init 1.0      # a different starting version
```

### Scoping to specific files

```sh
./scripts/version-snapshot --files docs/_mitigations/mi-1_code-review.md
```

---

## Viewing the site locally

Snapshots render through Jekyll like any other page. To preview:

```sh
# Option A — Docker (no Ruby needed)
make run                     # serves http://127.0.0.1:4000

# Option B — Ruby + Bundler
cd docs
bundle install
bundle exec jekyll serve     # serves http://127.0.0.1:4000
```

Open a mitigation page to see the version badge and Version History panel, and
click a version to open its frozen snapshot.

---

## Files involved

| File | Role |
|------|------|
| `docs/_mitigations/*.md`, `docs/_risks/*.md` | Live cards; each has a `version` field |
| `docs/_versions/*.md` | Generated, immutable snapshots (do not hand-edit) |
| `scripts/version-snapshot` | Slices snapshots, `--check`, `--init` |
| `docs/_config.yml` | Registers the `versions` collection |
| `docs/_layouts/version.html` | Renders a snapshot page with the historic banner |
| `docs/_includes/version-history.html` | The Version History panel on live cards |
| `Makefile` | `make snapshot`, `make snapshot-check` |
| `.github/workflows/version-snapshot-check.yml` | CI immutability guard |

## Design limitations / future options

- **Version sort is lexical**, so `v0.10` would sort before `v0.2`. Fine for
  low minor numbers; switch to date-based or numeric-aware sorting if needed.
- **Slicing is manual** (bump + `make snapshot`). Could be automated on a
  `doc-status` transition (e.g. auto-slice when a card reaches
  `Working-Group-Approved`).
- **No cross-version diff view** yet. Because snapshots are plain files, a
  "compare v0.1 ↔ v0.2" page could be added later.
