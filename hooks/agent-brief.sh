#!/bin/sh
root="${CLAUDE_PROJECT_DIR:-$PWD}"
marker=$(find "$root" -maxdepth 3 \( -name forge.yaml -o -name forge-factory.yaml \) -not -path '*/.forge/*' -print 2>/dev/null | head -n 1)
[ -n "$marker" ] || exit 0
input=$(cat)
if ! printf '%s' "$input" | grep -q 'forge-skills:meta'; then
  printf '%s\n' "forge-skills refuses this Agent call: the brief does not name forge-skills:meta. In a forge workspace every subagent brief tells the helper to invoke the forge-skills:meta skill first, in its first paragraph. Add that sentence and call again." >&2
  exit 2
fi
if printf '%s' "$input" | grep -Eq '"subagent_type" *: *"fork"'; then
  exit 0
fi
if ! printf '%s' "$input" | grep -Eq '"model" *: *"opus"'; then
  printf '%s\n' "forge-skills refuses this Agent call: the brief sets no model opus. In a forge workspace every subagent runs on model opus, the user's ruling of 2026-09-24. Pass model opus and call again." >&2
  exit 2
fi
exit 0
