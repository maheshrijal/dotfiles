# ── Environment & PATH (runs for all shells) ────────────────────────────────
set -gx EDITOR vim
set -gx VISUAL $EDITOR
set -gx BUN_INSTALL "$HOME/.bun"

# Tool paths — only added when the directory actually exists. Keep this static:
# external init commands run on every shell startup and are noticeably slower.
set -l path_candidates $HOME/.local/bin $BUN_INSTALL/bin

if test -d /System/Library/CoreServices
    # macOS: avoid probing /home; it can be slow on some systems.
    set -a path_candidates \
        /opt/homebrew/bin \
        /opt/homebrew/sbin \
        /usr/local/bin \
        /usr/local/sbin \
        /opt/homebrew/opt/mysql-client/bin
else
    set -a path_candidates \
        /home/linuxbrew/.linuxbrew/bin \
        /home/linuxbrew/.linuxbrew/sbin \
        /home/linuxbrew/.linuxbrew/opt/mysql-client/bin
end

set -a path_candidates $HOME/.grok/bin $HOME/.antigravity/antigravity/bin

set -l path_prefixes
for dir in $path_candidates
    if test -d $dir; and not contains -- $dir $PATH
        set -a path_prefixes $dir
    end
end
test (count $path_prefixes) -gt 0; and set -gx PATH $path_prefixes $PATH

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
    abbr -a cs 'claude --model claude-sonnet-4-6'
    abbr -a co 'claude --model claude-opus-4-8'

    # eza
    if command -q eza
        abbr -a la 'eza -abghl --git --color=automatic'
        abbr -a al 'eza -abghl --git --color=automatic'
        abbr -a ll 'eza -bghl --git --color=automatic'
    end
end
