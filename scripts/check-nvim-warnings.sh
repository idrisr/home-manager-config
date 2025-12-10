#!/usr/bin/env bash

# Run Neovim headlessly and fail with exit 1 if any startup warnings/errors occur.

set -euo pipefail

tmp_dir="$(mktemp -d)"
stderr_log="$tmp_dir/stderr.log"
stdout_log="$tmp_dir/stdout.log"
nvim_log="$tmp_dir/nvim.log"

cleanup() {
  rm -rf "$tmp_dir"
}
trap cleanup EXIT

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lua_probe="$script_dir/check-nvim-warnings.lua"

if [[ ! -f "$lua_probe" ]]; then
  echo "Lua probe not found: $lua_probe" >&2
  exit 2
fi

NVIM_BIN="${NVIM_BIN:-nvim}"

if [[ -z "${XDG_STATE_HOME:-}" ]]; then
  export XDG_STATE_HOME="$tmp_dir/state"
fi
if [[ -z "${XDG_CACHE_HOME:-}" ]]; then
  export XDG_CACHE_HOME="$tmp_dir/cache"
fi
mkdir -p "$XDG_STATE_HOME" "$XDG_CACHE_HOME"

export NVIM_LOG_FILE="$nvim_log"

nvim_cmd=(
  "$NVIM_BIN"
  --headless
  "$@"
  --cmd "set shadafile="
  --cmd "luafile $lua_probe"
)

if ! "${nvim_cmd[@]}" >"$stdout_log" 2>"$stderr_log"; then
  [[ -s "$stderr_log" ]] && cat "$stderr_log" >&2 || true
  [[ -s "$stdout_log" ]] && cat "$stdout_log" >&2 || true
  exit 1
fi

if [[ -s "$stderr_log" ]]; then
  cat "$stderr_log" >&2
  exit 1
fi

if [[ -s "$stdout_log" ]]; then
  cat "$stdout_log" >&2
  exit 1
fi

if [[ -f "$nvim_log" ]] && grep -E '\b(WARN|ERROR|FATAL)\b' "$nvim_log" >/dev/null 2>&1; then
  grep -E '\b(WARN|ERROR|FATAL)\b' "$nvim_log" >&2 || true
  exit 1
fi

exit 0
