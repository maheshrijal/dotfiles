- Please remove all mannered prose.
- Workspace: `/Users/mahesh/code`.

## Verify — before "done" and before anything irreversible
- Never apply infra unprompted. For `terraform apply`, prod `kubectl apply/delete`, migrations: render the plan/diff and wait for my explicit "go / no-go". Default to dry-run/diff, then a targeted apply scoped to only the resources I asked to change; if the plan shows unexpected diffs, stop and surface them — never a broad apply that sweeps in drift or newly-provisioned infra.
- I merge PRs myself. "Merged" is your cue to verify live state end-to-end (ArgoCD sync, pod ready, health check, startup logs) and confirm the old resource is retired — merge/sync ≠ done. Never declare done from PR state alone.
- Investigation/triage is read-only until I say act — read commands only, state findings, then wait.
- Prefer end-to-end verification; If you can't verify, say exactly what's blocking.

## Git
- Safe by default: `status` / `diff` / `log` freely.
- Don't push, amend, or run destructive ops (`reset --hard`, `clean`, `restore`, `rm`) unless I ask. Create or switch branches only as part of the PR flow below. A typed command ("pull and push") is consent for that command.
- PRs are surgically scoped: fresh branch off main, rebase on main first (drop already-merged commits), include only the files this task touches — never drift or other agents' edits. Clone to /tmp if the tree is dirty.
- Pre-existing bugs, perf concerns, or cleanup you notice while working: report them as follow-ups in the summary, don't fix them in this change unless the task cannot work without it. Keep scratch verification scripts under /tmp. Commit tests only where the task asks or the repo already tests that kind of change, sized like neighboring tests.
- Paste the PR URL immediately after opening/updating a PR — don't wait to be asked.
- Every change goes through a PR — never commit to a base branch. Follow-up on a merged PR => new branch + new PR.
- Never bypass commit signing — stop and ask.
- Commits: Conventional Commits (feat|fix|refactor|build|ci|chore|docs|style|perf|test).
- Remotes under /Users/mahesh/code: prefer SSH;
- Pulling a file in from upstream: land it on a scratch branch or stage a copy in /tmp, then cherry-pick it in — never overwrite a tracked file in place.
- Unrecognized changes: assume another agent; stay on your scope.

## Tools & runtime
- GitHub: use `gh` (`gh pr view/diff`, `gh run list/view`) — never web-search a PR/issue URL. Rerun/fix CI till green.
- "Make a note" => append to the repo's CLAUDE.md. 

## Docs & locations
- Keep notes short; update docs when behavior/API changes (no ship w/o docs). Add read_when hints on cross-cutting docs.
- Obsidian vault: `/Users/mahesh/Documents/Notes/Vault` (CLI: `obsidian`).

- I use fish. Write commands and shell scripts intended for me in fish; use any shell for your own temporary work.
