#!/bin/bash
# Orchestrator session-start hook
# Runs when Claude starts in the project root
# Generated from ns-worktree-setup default templates

# This is the orchestrator - we have full capabilities
# Worktrees have their own generated hooks with limited scope

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="${PROJECT_ROOT:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
PROJECT_NAME="$(basename "$PROJECT_ROOT" | tr '_' '-')"
WORKTREES_DIR="$PROJECT_ROOT/.worktrees"

# Generate root settings.local.json from template (keeps permissions in sync)
if command -v ns-generate-root-settings >/dev/null 2>&1; then
  PROJECT_ROOT="$PROJECT_ROOT" ns-generate-root-settings
fi

# Check for worktree status and report to orchestrator Claude
if [[ -d "$WORKTREES_DIR" ]]; then
  inactive=()
  active=()
  cleanable=()

  # Get branches merged into master (fast local check, no network)
  merged_list=""
  if merged_output=$(git -C "$PROJECT_ROOT" branch --merged master --format='%(refname:short)' 2>&1); then
    merged_list="$merged_output"
  fi

  PRESENCE_STALE_SECONDS="${PRESENCE_STALE_SECONDS:-900}"
  now=$(date +%s)

  for worktree_path in "$WORKTREES_DIR"/*; do
    [[ -d "$worktree_path" ]] || continue
    name=$(basename "$worktree_path")
    presence_file="/tmp/.$PROJECT_NAME-$name"

    is_active=false
    if [[ -f "$presence_file" ]]; then
      timestamp=$(tail -1 "$presence_file")
      if [[ "$timestamp" =~ ^[0-9]+$ ]]; then
        elapsed=$((now - timestamp))
        if [[ $elapsed -lt $PRESENCE_STALE_SECONDS ]]; then
          is_active=true
        fi
      fi
    fi

    if $is_active; then
      active+=("$name")
    elif [[ -n "$merged_list" ]] && echo "$merged_list" | grep -qxF "$name"; then
      # Check for uncommitted or untracked files before marking cleanable
      if worktree_dirty=$(git -C "$worktree_path" status --porcelain 2>/dev/null) && [[ -z "$worktree_dirty" ]]; then
        cleanable+=("$name")
      else
        inactive+=("$name (merged but has uncommitted work)")
      fi
    else
      inactive+=("$name")
    fi
  done

  if [[ ${#inactive[@]} -gt 0 ]]; then
    total=$(( ${#inactive[@]} + ${#active[@]} + ${#cleanable[@]} ))
    echo ""
    echo "INACTIVE WORKTREES (${#inactive[@]} of $total):"
    for name in "${inactive[@]}"; do
      echo "  $name"
    done
    echo ""
    echo "To open terminals with Claude auto-started: ns-open-inactive-worktrees"
  fi

  if [[ ${#cleanable[@]} -gt 0 ]]; then
    echo ""
    echo "CLEANABLE WORKTREES (${#cleanable[@]}):"
    for name in "${cleanable[@]}"; do
      echo "  $name (merged into master)"
    done
    echo ""
    echo "To clean up: ns-worktree-cleanup <branch-name>"
  fi
fi
