# CLAUDE.md

## How I work
- Workspace: /Users/mahesh/code. Editor: `code <path>`.
- Fix the root cause, not a workaround. When something breaks then works, tell me what was wrong and how to prevent a repeat.
- Keep edits small/reviewable. No repo-wide search/replace. No unsolicited cleanup or big refactors unless I ask.
- Code comments: short one-liners. Don't narrate obvious code.
- ~500 LOC/file is a smell, not a hard cap — split when it aids clarity.
- New deps: quick health check (recent releases, adoption) first.

## Verify — before "done" and before anything irreversible
- IMPORTANT — never apply infra unprompted. For `terraform apply`, prod `kubectl apply/delete`, migrations: render the plan/diff and wait for my explicit "go / no-go". Default to dry-run/diff.
- Prefer end-to-end verification; If you can't verify, say exactly what's blocking.
- Bugs: add a regression test when it fits.

## Git
- Safe by default: `status` / `diff` / `log` freely.
- YOU MUST NOT push, create/switch branches, amend, or run destructive ops (`reset --hard`, `clean`, `restore`, `rm`) unless I ask. A typed command ("pull and push") is consent for that command.
- Every change goes through a PR — never commit directly to a base branch. Follow-up on a merged PR => new branch + new PR.
- Never bypass commit signing — stop and ask.
- Commits: Conventional Commits (feat|fix|refactor|build|ci|chore|docs|style|perf|test).
- Remotes under /Users/mahesh/code: prefer SSH; flip HTTPS->SSH first.
- Upstream file: stage in /tmp/ then cherry-pick; never overwrite tracked.
- Unrecognized changes: assume another agent; stay on your scope.

## Tools & runtime
- GitHub: use `gh` (`gh pr view/diff`, `gh run list/view`) — never web-search a PR/issue URL. Rerun/fix CI till green.
- Use the repo's package manager/runtime; no swaps without approval.
- "Make a note" => append to the repo's CLAUDE.md. 

## Docs & locations
- Keep notes short; update docs when behavior/API changes (no ship w/o docs). Add read_when hints on cross-cutting docs.
- Obsidian vault: `/Users/mahesh/Documents/Notes/Vault` (CLI: `obsidian`).
