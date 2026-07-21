#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "usage: $0 CHECK_FILE" >&2
  exit 64
fi

workspace_dir="/root/proof-factory/research/scout-bdf77f43574b/workspace"
checkout_dir="$workspace_dir/.upstream/formal-conjectures"
lake_bin="/root/.cache/proof-factory/lean/elan/toolchains/leanprover--lean4---v4.27.0/bin/lake"
check_file="$workspace_dir/$1"

sha256sum "$check_file"
"$lake_bin" --version
exec env LEAN_NUM_THREADS=1 "$lake_bin" --dir "$checkout_dir" env lean "$check_file"
