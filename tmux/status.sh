#!/usr/bin/env bash
# tmux status segments. Uses only bash builtins and /proc + /sys reads
# (no top/free/awk/sensors forks), except nvidia-smi for the GPU.
# Usage: status.sh cpu|memory|gpu|spotify|pomo|email [path]
# Output is padded with one space on each side, or empty when there is nothing to
# show, so an empty tmux segment collapses to zero width instead of a blank block.

cpu() {
  # CPU usage = delta of /proc/stat since the previous call (tmux calls us every
  # status-interval), so it reflects the last interval, not the average since boot.
  local state="${XDG_RUNTIME_DIR:-/tmp}/tmux-status-cpu.$UID"
  local _ user nice system idle iowait irq softirq steal
  read -r _ user nice system idle iowait irq softirq steal _ </proc/stat
  local total=$((user + nice + system + idle + iowait + irq + softirq + steal))
  local busy=$((total - idle - iowait))

  local prev_total=0 prev_busy=0
  [[ -r $state ]] && read -r prev_total prev_busy <"$state"
  printf '%s %s\n' "$total" "$busy" >"$state"

  local dt=$((total - prev_total)) usage=0
  ((dt > 0 && prev_total > 0)) && usage=$(((busy - prev_busy) * 100 / dt))

  # AMD k10temp (Tctl); hwmonN numbering can change between boots, so match by name.
  local temp="" h name
  for h in /sys/class/hwmon/hwmon*; do
    read -r name <"$h/name" 2>/dev/null
    if [[ $name == k10temp || $name == coretemp ]]; then
      read -r temp <"$h/temp1_input" && temp=" $((temp / 1000))°C"
      break
    fi
  done

  printf 'CPU: %d%%%s' "$usage" "$temp"
}

memory() {
  # "used" = MemTotal - MemAvailable (same as free's "used" column)
  local key val total=0 avail=0
  while read -r key val _; do
    case $key in
      MemTotal:) total=$val ;;
      MemAvailable:) avail=$val; break ;;
    esac
  done </proc/meminfo
  printf 'Memory: %d/%dMB' $(((total - avail) / 1024)) $((total / 1024))
}

gpu() {
  local temp
  temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits 2>/dev/null) || return
  printf 'GPU: %s°C' "${temp%%$'\n'*}"
}

spotify() {
  # Spotify's current track via MPRIS (D-Bus); prints nothing if Spotify isn't running.
  command -v playerctl >/dev/null || return
  playerctl -p spotify metadata --format '{{artist}} - {{title}}' 2>/dev/null
}

pomo() {
  command -v pomo >/dev/null || return
  command pomo 2>/dev/null
}

email() {
  # Run git inside the pane's directory so ~/.gitconfig includeIf "gitdir:"
  # rules apply (personal repos -> gmail, work repos -> work email).
  local dir="${1:-$PWD}"
  if git -C "$dir" rev-parse --git-dir >/dev/null 2>&1; then
    git -C "$dir" config user.email 2>/dev/null
    return
  fi

  # Not a repo: git ignores includeIf "gitdir:" here, so match the rules ourselves
  # to show the email a repo in this directory would get. Last match wins, like git.
  local key file pattern email
  while read -r key file; do
    pattern=${key#includeif.gitdir:}
    pattern=${pattern%.path}
    pattern=${pattern/#\~/$HOME}
    [[ $pattern == */ ]] && pattern+="**"
    # shellcheck disable=SC2053  # pattern must stay unquoted to glob-match
    if [[ $dir/ == $pattern ]]; then
      email=$(git config -f "${file/#\~/$HOME}" user.email 2>/dev/null) || continue
    fi
  done < <(git config --global --get-regexp '^includeif\.gitdir:.*\.path$' 2>/dev/null)

  printf '%s' "${email:-$(git config --global user.email)}"
}

case $1 in
  cpu | memory | gpu | spotify | pomo | email)
    out=$("$@")
    out=${out%%$'\n'*} # tmux shows only the first line
    [[ -n $out ]] && printf ' %s ' "$out"
    ;;
  *) echo "usage: $0 cpu|memory|gpu|spotify|pomo|email [path]" >&2; exit 1 ;;
esac
