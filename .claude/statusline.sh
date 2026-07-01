#!/bin/bash
# Claude Code status line — Catppuccin Mocha pill style
# Segments: git (teal) → model (mauve) → ctx / 5h / 7d gauge pills
# Requires a Nerd Font terminal.

input=$(cat)

CRUST="17;17;27"
TEXT="205;214;244"
SUBTEXT0="166;173;200"
SURFACE1="28;28;28"
SURFACE2="68;68;68"
TEAL="203;166;247"
MAUVE="255;135;0"
GREEN="166;227;161"
YELLOW="249;226;175"
RED="243;139;168"

ESC=$'\033'
RESET="${ESC}[0m"
BOLD="${ESC}[1m"
fg() { printf '%s[38;2;%sm' "$ESC" "$1"; }
bg() { printf '%s[48;2;%sm' "$ESC" "$1"; }

CAP_L=$(printf '\xee\x82\xb6')
CAP_R=$(printf '\xee\x82\xb4')
G_BRANCH=$(printf '\xee\x82\xa0')
G_CLOCK=$(printf '\xef\x80\x97')

IFS=$'\t' read -r DIR MODEL CTX_PCT FIVE_H_PCT FIVE_H_RESET SEVEN_D_PCT SEVEN_D_RESET < <(
  printf '%s' "$input" | jq -r '[
    (.workspace.current_dir // ""),
    (.model.display_name // ""),
    (if .context_window.used_percentage != null then (.context_window.used_percentage | tostring) else "" end),
    (if .rate_limits.five_hour.used_percentage != null then (.rate_limits.five_hour.used_percentage | tostring) else "" end),
    (if .rate_limits.five_hour.resets_at != null then (.rate_limits.five_hour.resets_at | floor | tostring) else "" end),
    (if .rate_limits.seven_day.used_percentage != null then (.rate_limits.seven_day.used_percentage | tostring) else "" end),
    (if .rate_limits.seven_day.resets_at != null then (.rate_limits.seven_day.resets_at | floor | tostring) else "" end)
  ] | join("\t")'
)

threshold_color() {
  if   [ "$1" -ge 80 ]; then printf '%s' "$RED"
  elif [ "$1" -ge 50 ]; then printf '%s' "$YELLOW"
  else                        printf '%s' "$GREEN"
  fi
}

render_reset() {
  local resets_at=$1 now diff d h m
  now=$(date +%s)
  diff=$(( resets_at - now ))
  [ "$diff" -le 0 ] && return
  d=$(( diff / 86400 )); h=$(( (diff % 86400) / 3600 )); m=$(( (diff % 3600) / 60 ))
  if   [ "$d" -gt 0 ]; then printf ' %s %dd %dh' "$G_CLOCK" "$d" "$h"
  elif [ "$h" -gt 0 ]; then printf ' %s %dh %dm' "$G_CLOCK" "$h" "$m"
  else                       printf ' %s %dm' "$G_CLOCK" "$m"
  fi
}

pill() {
  local acc=$1 text=$2
  printf '%s%s%s%s%s %s %s%s%s%s' \
    "$(fg "$acc")" "$CAP_L" \
    "$(bg "$acc")" "$(fg "$CRUST")" "$BOLD" "$text" \
    "$RESET" "$(fg "$acc")" "$CAP_R" "$RESET"
}

pill_gauge() {
  local color=$1 label=$2 pctv=$3 reset=$4
  local pi filled i out
  pi=$(printf '%.0f' "$pctv"); [ "$pi" -gt 100 ] && pi=100
  filled=$(( (pi + 5) / 10 )); [ "$filled" -gt 10 ] && filled=10
  out="$(fg "$SURFACE1")$CAP_L$(bg "$SURFACE1")$BOLD"
  out="${out}$(fg "$TEXT") ${label} "
  out="${out}$(fg "$color")"
  for ((i = 0; i < filled; i++)); do out="${out}▰"; done
  out="${out}$(fg "$SURFACE2")"
  for ((i = filled; i < 10; i++)); do out="${out}▱"; done
  out="${out}$(fg "$color") ${pi}%"
  [ -n "$reset" ] && out="${out}$(fg "$SUBTEXT0")${reset}"
  out="${out} ${RESET}$(fg "$SURFACE1")$CAP_R$RESET"
  printf '%s' "$out"
}

pills=()
if [ -n "$DIR" ]; then
  branch=$(git -C "$DIR" branch --show-current 2>/dev/null)
  [ -n "$branch" ] && pills+=("$(pill "$TEAL" "${G_BRANCH} ${branch}")")
fi
[ -n "$MODEL" ] && pills+=("$(pill "$MAUVE" "$MODEL")")
if [ -n "$CTX_PCT" ]; then
  c=$(threshold_color "$(printf '%.0f' "$CTX_PCT")")
  pills+=("$(pill_gauge "$c" "ctx" "$CTX_PCT" "")")
fi
if [ -n "$FIVE_H_PCT" ]; then
  c=$(threshold_color "$(printf '%.0f' "$FIVE_H_PCT")")
  reset=""; [ -n "$FIVE_H_RESET" ] && reset="$(render_reset "$FIVE_H_RESET")"
  pills+=("$(pill_gauge "$c" "5h" "$FIVE_H_PCT" "$reset")")
fi
if [ -n "$SEVEN_D_PCT" ]; then
  c=$(threshold_color "$(printf '%.0f' "$SEVEN_D_PCT")")
  reset=""; [ -n "$SEVEN_D_RESET" ] && reset="$(render_reset "$SEVEN_D_RESET")"
  pills+=("$(pill_gauge "$c" "7d" "$SEVEN_D_PCT" "$reset")")
fi

line=""
for i in "${!pills[@]}"; do
  [ "$i" -gt 0 ] && line="${line} "
  line="${line}${pills[$i]}"
done
printf '%b\n' "$line"
