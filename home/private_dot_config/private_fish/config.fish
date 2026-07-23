# ── Environment & PATH (runs for all shells) ────────────────────────────────
set -gx EDITOR vim
set -gx VISUAL $EDITOR
set -gx BUN_INSTALL "$HOME/.bun"

# Always-present paths (fish_add_path is idempotent — no duplicates)
fish_add_path -g $HOME/.local/bin $BUN_INSTALL/bin

# Homebrew shell environment
if test -x /opt/homebrew/bin/brew
    /opt/homebrew/bin/brew shellenv fish | source
else if test -x /usr/local/bin/brew
    /usr/local/bin/brew shellenv fish | source
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    /home/linuxbrew/.linuxbrew/bin/brew shellenv fish | source
end

# Optional tool paths — only added when the directory actually exists
for dir in $HOME/.grok/bin $HOME/.antigravity/antigravity/bin /opt/homebrew/opt/mysql-client/bin /home/linuxbrew/.linuxbrew/opt/mysql-client/bin
    test -d $dir; and fish_add_path -g $dir
end

# OrbStack CLI integration (managed by OrbStack)
test -f ~/.orbstack/shell/init2.fish; and source ~/.orbstack/shell/init2.fish 2>/dev/null

# ── Interactive sessions ─────────────────────────────────────────────────────
if status is-interactive
    set -g fish_greeting
    command -q starship; and starship init fish | source

    # git
    abbr -a gs 'git status'
    abbr -a gp 'git pull'
    abbr -a gpsh 'git push'
    abbr -a gc 'git commit -asm'

    # claude
    abbr -a cs 'claude --model claude-sonnet-5'
    abbr -a co 'claude --model claude-opus-4-8'

    # eza
    if command -q eza
        abbr -a la 'eza -abghl --git --color=auto'
        abbr -a al 'eza -abghl --git --color=auto'
        abbr -a ll 'eza -bghl --git --color=auto'
    end
end

# Pi
fish_add_path "/Users/mahesh/.local/share/fnm/node-versions/v24.15.0/installation/bin"

# pnpm
set -gx PNPM_HOME "/Users/mahesh/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
