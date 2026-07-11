# CLAUDE.md

## How I work
- Workspace: /Users/mahesh/code. Editor: `code <path>`.
- Fix the root cause, not a workaround. When something breaks then works, tell me what was wrong and how to prevent a repeat.
- Never assert infra/repo state from assumption — grep/read the actual repo and check live cluster + real usage data first (a resource existing ≠ it's used, or that it's the right repo). Reason from concrete evidence when I paste it (grants, ARNs, logs).
- Keep edits small/reviewable. No repo-wide search/replace. No unsolicited cleanup or big refactors unless I ask.
- Code comments: short one-liners. Don't narrate obvious code.
- ~500 LOC/file is a smell, not a hard cap — split when it aids clarity.
- New deps: quick health check (recent releases, adoption) first.
- Prefer the simplest solution; if a simpler path exists, propose it.

## Preferences
- If I asked you to do too much work at once, stop and state that clearly. 

## Thinking partnership (keep me sharp)
- Design/architecture questions: give me the tradeoff space and prior art first, your recommendation last. If I haven't stated my own take, ask for it before giving yours.
- RFCs, design docs, postmortems: I draft, you critique. Challenge my reasoning, find holes, suggest structure — don't write the first version.
- Don't cave to pushback. If I disagree and you still think you're right, hold your position and show the evidence. Only concede on new information, never to be agreeable.
- Cite your sources: when making claims about tools/APIs/behavior, point to docs, code, or output I can check — act like a librarian, not an oracle.
- When a fix uses something non-obvious (a flag, an API quirk, a pattern), add a one-line explanation so I learn it, not just receive it.

## Verify — before "done" and before anything irreversible
- IMPORTANT — never apply infra unprompted. For `terraform apply`, prod `kubectl apply/delete`, migrations: render the plan/diff and wait for my explicit "go / no-go". Default to dry-run/diff, then a TARGETED apply scoped to ONLY the resources I asked to change; if the plan shows unexpected diffs, stop and surface them — never a broad apply that sweeps in drift or newly-provisioned infra.
- IMPORTANT — I merge PRs myself. "Merged" is your cue to verify LIVE state end-to-end (ArgoCD sync, pod ready, health check, startup logs) and confirm the old resource is retired — merge/sync ≠ done. Never declare done from PR state alone.
- Investigation/triage is read-only until I say act — read commands only, state findings, then wait.
- Prefer end-to-end verification; If you can't verify, say exactly what's blocking.
- Bugs: add a regression test when it fits.

## Git
- Safe by default: `status` / `diff` / `log` freely.
- YOU MUST NOT push, create/switch branches, amend, or run destructive ops (`reset --hard`, `clean`, `restore`, `rm`) unless I ask. A typed command ("pull and push") is consent for that command.
- IMPORTANT — PRs are surgically scoped: fresh branch off main, rebase on main first (drop already-merged commits), include ONLY the files this task touches — never drift or other agents' edits. Clone to /tmp if the tree is dirty.
- Paste the PR URL immediately after opening/updating a PR — don't wait to be asked.
- Every change goes through a PR — never commit to a base branch. Follow-up on a merged PR => new branch + new PR.
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
