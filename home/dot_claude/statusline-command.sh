#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
home="$HOME"
display_dir="${cwd/#$home/~}"

branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" symbolic-ref --short HEAD 2>/dev/null)

model=$(echo "$input" | jq -r '.model.display_name // .model.id // empty')
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

parts=""

if [ -n "$model" ]; then
  parts="$model"
fi

if [ -n "$parts" ]; then
  parts="$parts  $display_dir"
else
  parts="$display_dir"
fi

if [ -n "$branch" ]; then
  parts="$parts  $branch"
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
