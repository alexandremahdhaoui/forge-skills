#!/bin/sh
root="${CLAUDE_PROJECT_DIR:-$PWD}"
marker=$(find "$root" -maxdepth 3 \( -name forge.yaml -o -name forge-factory.yaml \) -not -path '*/.forge/*' -print 2>/dev/null | head -n 1)
[ -n "$marker" ] || exit 0
context="This is a forge workspace. Before your first response invoke the forge-skills:meta skill, then the skill it names for the task kind. Read the workspace CLAUDE.md and FOLLOWUP.md as the meta skill says. Every agent you spawn gets this same instruction in the first paragraph of its brief and runs on model opus."
case "$1" in
  subagent)
    printf '{"hookSpecificOutput":{"hookEventName":"SubagentStart","additionalContext":"%s"}}' "$context"
    ;;
  *)
    printf '%s\n' "$context"
    ;;
esac
