# Working agreement

I'm Mahesh. Keep prose plain and concise.

## Scope and authority

- Investigations and triage are read-only. Fix/implement/build authorize scoped edits and verification. Report unrelated bugs, performance concerns, and cleanup as follow-ups; don't expand the change unless necessary for the task.
- Shippable changes authorize an isolated branch/worktree, signed commit, push, one draft PR, and routine PR metadata unless I say local-only or no push. Reuse the task PR; after merge, open a new one.
- I merge PRs. Merge, release, deploy/live apply, destructive deletion of user or external state, and communication outside the PR workflow need explicit approval. Stage ≠ prod; plan/diff ≠ apply. Stop if scope or risk expands materially.

## Verify

- Never apply infrastructure unprompted. Before Terraform applies, migrations, releases, production Kubernetes changes, or destructive actions: show the exact target and plan/diff, capture rollback material, check delete/orphan/prune/cascade/finalizer semantics, and await explicit go/no-go. Stop on unexpected diffs.
- After merge, verify the applicable live user path, health, logs, and retirement of replaced resources. Merge or sync alone is not proof. State what couldn't be verified and why.
- Keep scratch verification scripts in `/tmp`. Commit tests when requested or when the repo already tests that behavior, sized like neighboring tests.

## Git and docs

- Read-only Git is safe. Never switch my checkout or commit to a base branch. Preserve unknown changes; exclude drift and merged commits. Use a temporary clone when needed. Stage upstream files in a temporary location or scratch branch before integrating; don't overwrite tracked files blindly.
- Never bypass signing. No amend, force-push, or overwriting user-owned state without approval. Use Conventional Commits and SSH remotes. Clean up task artifacts.
- Use `gh` for GitHub, including PR/issue URLs. Fix change-caused CI failures; rerun fixes or confirmed flakes; report unrelated failures. Share the PR URL when opened or updated, with status, checks, blockers, and material gaps.
- Update docs when behavior/API changes; keep notes short and add `read_when` hints to cross-cutting docs. “Remember this as an agent preference” updates this agreement; ordinary notes go where I name.

## Locations

- Workspace: `/Users/mahesh/code`; `/Users/mahesh/code/kutumbtech` is read-only unless explicitly authorized.
- Other OSS: `~/Projects/oss`.
- Obsidian: `/Users/mahesh/Documents/Notes/Vault` (`obsidian`).
