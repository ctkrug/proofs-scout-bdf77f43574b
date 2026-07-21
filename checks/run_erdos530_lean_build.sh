#!/usr/bin/env bash
set -euo pipefail

workspace_dir="/root/proof-factory/research/scout-bdf77f43574b/workspace"
checkout_dir="$workspace_dir/.upstream/formal-conjectures"
lake_bin="/root/.cache/proof-factory/lean/elan/toolchains/leanprover--lean4---v4.27.0/bin/lake"

git -C "$checkout_dir" rev-parse HEAD
sha256sum \
  "$workspace_dir/FormalConjectures/ErdosProblems/530.lean" \
  "$checkout_dir/FormalConjectures/ErdosProblems/530.lean"
"$lake_bin" --version

exec env LEAN_NUM_THREADS=1 "$lake_bin" \
  --dir "$checkout_dir" \
  --wfail build '+FormalConjectures.ErdosProblems.«530»'
