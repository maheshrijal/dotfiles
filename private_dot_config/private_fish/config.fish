# ── Environment & PATH (runs for all shells) ────────────────────────────────
set -gx BUN_INSTALL "$HOME/.bun"

# Always-present paths (fish_add_path is idempotent — no duplicates)
fish_add_path -g $HOME/.local/bin $BUN_INSTALL/bin

# Optional tool paths — only added when the directory actually exists
for dir in $HOME/.grok/bin $HOME/.antigravity/antigravity/bin /opt/homebrew/opt/mysql-client/bin
    test -d $dir; and fish_add_path -g $dir
end

# OrbStack CLI integration (managed by OrbStack)
test -f ~/.orbstack/shell/init2.fish; and source ~/.orbstack/shell/init2.fish 2>/dev/null

# ── Interactive sessions ─────────────────────────────────────────────────────
if status is-interactive
    starship init fish | source

    # git
    abbr -a gs 'git status'
    abbr -a gp 'git pull'
    abbr -a gpsh 'git push'

    # claude
    abbr -a cs 'claude --model claude-sonnet-4-6'
    abbr -a co 'claude --model claude-opus-4-8'

    # ccusage
    abbr -a ccusage 'bunx ccusage'
    abbr -a ccusage-codex 'bunx @ccusage/codex@latest'

    # eza
    if command -q eza
        abbr -a la 'eza -abghl --git --color=automatic'
        abbr -a al 'eza -abghl --git --color=automatic'
        abbr -a ll 'eza -bghl --git --color=automatic'
    end
end
