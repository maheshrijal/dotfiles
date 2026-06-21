# AGENTS.MD

## Agent Protocol

- Workspace: /Users/mahesh/code.
- PRs: use gh pr view/diff (no URLs).
- “Make a note” => edit AGENTS.md (shortcut; not a blocker). Ignore CLAUDE.md.
- Need upstream file: stage in /tmp/, then cherry-pick; never overwrite tracked.
- Bugs: add regression test when it fits.
- Keep files <~500 LOC; split/refactor as needed.
- Commits: Conventional Commits (feat|fix|refactor|build|ci|chore|docs|style|perf|test).
- Editor: code <path>.
- CI: gh run list/view (rerun/fix til green).
- Prefer end-to-end verify; if blocked, say what’s missing.
- New deps: quick health check (recent releases/commits, adoption).
- Slash cmds: ~/.codex/prompts/.

## Important Locations
- Obsidian vault: `/Users/mahesh/Documents/Notes/Vault`; CLI: `obsidian`

## Docs
- Follow links until domain makes sense; honor Read when hints.
- Keep notes short; update docs when behavior/API changes (no ship w/o docs).
- Add read_when hints on cross-cutting docs.


## Flow & Runtime
- Use repo’s package manager/runtime; no swaps w/o approval.
- Use Codex background for long jobs; tmux only for interactive/persistent (debugger/server).

## Git
- Safe by default: git status/diff/log. Push only when user asks.
- Branch changes require user consent.
- Never bypass signing; stop + ask. 
- Destructive ops forbidden unless explicit (reset --hard, clean, restore, rm, …).
- Remotes under /Users/mahesh/code: prefer SSH; flip HTTPS->SSH before pull/push.
- Don’t delete/rename unexpected stuff; stop + ask.
- No repo-wide S/R scripts; keep edits small/reviewable.
- If user types a command (“pull and push”), that’s consent for that command.
- No amend unless asked.
- Unrecognized changes: assume other agent; keep going; focus your changes. If it causes issues, stop + ask user.

## Tools

### gh
- GitHub CLI for PRs/CI/releases. Given issue/PR URL (or /pull/5): use gh, not web search.

### tmux
- Use only when you need persistence/interaction (debugger/server).
- Quick refs: tmux new -d -s codex-shell, tmux attach -t codex-shell, tmux list-sessions, tmux kill-session -t codex-shell.

<!-- context7 -->
Use Context7 MCP to fetch current documentation whenever the user asks about a library, framework, SDK, API, CLI tool, or cloud service -- even well-known ones like React, Next.js, Prisma, Express, Tailwind, Django, or Spring Boot. This includes API syntax, configuration, version migration, library-specific debugging, setup instructions, and CLI tool usage. Use even when you think you know the answer -- your training data may not reflect recent changes. Prefer this over web search for library docs.

Do not use for: refactoring, writing scripts from scratch, debugging business logic, code review, or general programming concepts.

## Steps

1. Always start with `resolve-library-id` using the library name and the user's question, unless the user provides an exact library ID in `/org/project` format
2. Pick the best match (ID format: `/org/project`) by: exact name match, description relevance, code snippet count, source reputation (High/Medium preferred), and benchmark score (higher is better). If results don't look right, try alternate names or queries (e.g., "next.js" not "nextjs", or rephrase the question). Use version-specific IDs when the user mentions a version
3. `query-docs` with the selected library ID and the user's full question (not single words)
4. Answer using the fetched docs
<!-- context7 -->
