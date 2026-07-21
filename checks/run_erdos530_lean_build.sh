#!/usr/bin/env bash
set -euo pipefail

workspace_dir="/root/proof-factory/research/scout-bdf77f43574b/workspace"
checkout_dir="$workspace_dir/.upstream/formal-conjectures"
lake_bin="/root/.cache/proof-factory/lean/elan/toolchains/leanprover--lean4---v4.27.0/bin/lake"
expected_candidate_sha256="208af82a29f35bf60d55f86669f7794cf30aae39d71eb24968f255b8cfa771c9"
candidate="$workspace_dir/FormalConjectures/ErdosProblems/530.lean"
checkout_candidate="$checkout_dir/FormalConjectures/ErdosProblems/530.lean"
olean="$checkout_dir/.lake/build/lib/lean/FormalConjectures/ErdosProblems/530.olean"

git -C "$checkout_dir" rev-parse HEAD
candidate_sha256="$(sha256sum "$candidate" | cut -d ' ' -f 1)"
test "$candidate_sha256" = "$expected_candidate_sha256"
cmp --silent "$candidate" "$checkout_candidate"
sha256sum "$candidate" "$checkout_candidate"
"$lake_bin" --version

env LEAN_NUM_THREADS=1 "$lake_bin" \
  --dir "$checkout_dir" \
  --wfail build '+FormalConjectures.ErdosProblems.«530»'

test -s "$olean"
sha256sum "$olean"
