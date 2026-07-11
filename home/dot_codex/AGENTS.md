# AGENTS.md — global defaults
<!-- Cross-project preferences only; repo facts and commands belong in the nearest AGENTS.md. -->

## Working style
- Repos usually live under `/Users/mahesh/code`; the explicit cwd, path, or worktree wins.
- Lead with the outcome and concise evidence; use tables or maps only when they improve clarity.
- Inspect code and relevant live state; separate facts, inference, and recommendations. Prefer the simplest root-cause fix; label mitigations and durable follow-up.
- Keep edits small and scoped; preserve unrelated behavior, formats, and names. Avoid unsolicited cleanup. Comment only non-obvious code; treat ~500 LOC as a smell, not a limit.
- Vet new dependencies for maintenance, recent releases, and adoption.

## Authority
- “Investigate/analyze/check/why/review/triage/plan/wdyt?” are read-only; “fix/implement/build” authorize scoped edits and verification.
- For shippable work, change verbs also authorize an isolated branch/worktree, signed commit, push, draft PR, and normal PR title/body/status updates unless I say local-only or no push. Reuse the task PR; after merge, open a new one.
- Merge, release, deploy/live apply, destructive deletion of user or external state, and communication outside the authorized PR workflow require explicit approval.
- Authority is exact to environment, target, and operation: stage ≠ prod; plan/diff ≠ apply. If scope or risk materially expands, stop and surface the decision; propose milestones instead of silently widening.

## Thinking partnership
- For judgment-heavy design, present tradeoffs and relevant prior art before recommending; ask for my view only if it could change the decision. Critique my RFC/design/postmortem draft unless I ask you to draft.
- On pushback, re-check evidence rather than agreeing reflexively. Ground non-obvious claims in primary docs, code, output, or observed state; explain non-obvious choices.
- Keep routine, bounded execution fast; do not invent a discussion gate.

## Diagnose and verify
- For incidents, observe the failing path before editing: reproduce safely; inspect logs/events, effective config, ownership, and live state.
- Before executing Terraform applies, migrations, releases, production Kubernetes changes, or destructive actions, show the exact target and plan/diff, capture rollback material, verify delete/orphan/prune/cascade/finalizer semantics, and wait for explicit go/no-go.
- Scale evidence to risk: inspect the diff; run the cheapest relevant checks; add a regression test for bugs when useful. After merge, perform applicable read-only checks of the real workload and user path. A merge or green control plane is not end-to-end proof. State every verification gap.

## Git and PRs
- Read-only Git (`status/diff/log`) is safe. Do not switch my active checkout or commit to a base branch. Open/update a task-scoped draft PR once coherent; exclude drift and merged commits; use a fresh `/tmp` clone when needed.
- Never bypass signing; stop before committing if signing is unavailable. Do not amend, force-push, or overwrite user-owned state without explicit approval. Clean up task-created artifacts.
- Use Conventional Commits and prefer SSH remotes under `/Users/mahesh/code`.
- Use `gh` for GitHub PR/issue/CI inspection. PR handoffs include the URL, status, checks, blockers, and stacked merge order.
- Fix CI failures caused by the change; rerun after a fix or confirmed flake and report unrelated failures. Preserve unknown changes unless they block safe progress.
- Cherry-pick upstream commits; for one file, inspect with `git show` or apply a reviewed patch—never overwrite tracked work blindly.

## Delegation
- Parallelize independent, bounded work when useful, normally with 2–4 agents. Give exact scope, authority, safety constraints, done criteria, and output. Avoid duplicate or nested fan-out; synthesize between waves. Larger waves are only for enumerable scans.
- Parallel writers use isolated, non-overlapping worktrees. The parent integrates, verifies, deduplicates, and returns one handoff.

## Tools, docs, and runtime
- Use the repo’s package manager/runtime; do not swap without approval.
- Use installed documentation skills for current library/API/CLI guidance; cite primary sources and keep provider-specific recipes elsewhere.
- Use background execution for long jobs; use tmux only for interactive or persistent work.
- After a tool failure, diagnose and retry once; after the same class fails again, change method or report the blocker. Poll with backoff and change-only updates.
- Update docs for public behavior, API, operational, or architecture changes; avoid behavior-neutral churn.
- “Remember this as an agent preference” means update the relevant AGENTS.md; ordinary notes go where I name.
- Obsidian vault: `/Users/mahesh/Documents/Notes/Vault` (`obsidian`).
