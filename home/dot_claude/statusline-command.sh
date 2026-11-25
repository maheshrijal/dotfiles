#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
home="$HOME"

repo_name=$(echo "$input" | jq -r '.workspace.repo.name // empty')
is_worktree=""

# One rev-parse: line 1 = this tree's git-dir, line 2 = the main repo's git-common-dir.
# They differ iff we're in a linked worktree — more reliable than any JSON field.
git_dirs=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" rev-parse --path-format=absolute --git-dir --git-common-dir 2>/dev/null)
git_dir=$(printf '%s\n' "$git_dirs" | sed -n '1p')
common_git_dir=$(printf '%s\n' "$git_dirs" | sed -n '2p')

if [ -n "$common_git_dir" ]; then
  # Repo name = the dir containing the main .git, so worktrees still read as the repo.
  [ -z "$repo_name" ] && repo_name=$(basename "$(dirname "$common_git_dir")")
  [ "$git_dir" != "$common_git_dir" ] && is_worktree=1
fi
[ -z "$repo_name" ] && repo_name="${cwd/#$home/~}"

display_dir="$repo_name"
[ -n "$is_worktree" ] && display_dir="$display_dir 🌿"

model=$(echo "$input" | jq -r '.model.display_name // .model.id // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

parts=""

if [ -n "$model" ]; then
  parts="$model"
  if [ -n "$effort" ]; then
    effort_label=$(printf '%s' "$effort" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
    parts="$parts [$effort_label]"
  fi
fi

if [ -n "$parts" ]; then
  parts="$parts  $display_dir"
else
  parts="$display_dir"
fi

if [ -n "$remaining" ]; then
  pct=$(printf '%.0f' "$remaining")
  total=10
  filled=$(( (pct + 5) / 10 ))
  [ "$filled" -lt 0 ] && filled=0
  [ "$filled" -gt "$total" ] && filled=$total
  empty=$(( total - filled ))
  bar=""
  i=0
  while [ "$i" -lt "$filled" ]; do bar="${bar}█"; i=$((i+1)); done
  i=0
  while [ "$i" -lt "$empty" ]; do bar="${bar}░"; i=$((i+1)); done
  parts="$parts  ${bar} ${pct}%"
fi

printf "%s" "$parts"
