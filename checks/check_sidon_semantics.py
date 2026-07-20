#!/usr/bin/env python3
"""Independent finite controls for the Sidon predicate used in Erdős #530.

This does not elaborate Lean and does not check the asymptotic statement.  It compares two
independent finite formulations of the Sidon condition on a fully stated bounded domain.
"""

from __future__ import annotations

import hashlib
import itertools
import json
from pathlib import Path


DOMAIN = tuple(range(-4, 5))


def sidon_by_quadruples(values: tuple[int, ...]) -> bool:
    """Literal translation of the four-variable implication in the Lean definition."""
    for a, b, c, d in itertools.product(values, repeat=4):
        if a + b == c + d and not ((a == c and b == d) or (a == d and b == c)):
            return False
    return True


def sidon_by_unordered_sums(values: tuple[int, ...]) -> bool:
    """Materially different encoding: unordered pairs with repetition have unique sums."""
    seen: dict[int, tuple[int, int]] = {}
    for a, b in itertools.combinations_with_replacement(values, 2):
        total = a + b
        if total in seen and seen[total] != (a, b):
            return False
        seen[total] = (a, b)
    return True


def weak_sidon_excluding_doubles(values: tuple[int, ...]) -> bool:
    """Known-bad control: ignores sums a+a."""
    sums = [a + b for a, b in itertools.combinations(values, 2)]
    return len(sums) == len(set(sums))


def too_strong_ordered_pair_sidon(values: tuple[int, ...]) -> bool:
    """Known-bad control: treats (a,b) and (b,a) as different representations."""
    sums = [a + b for a, b in itertools.product(values, repeat=2)]
    return len(sums) == len(set(sums))


def all_subsets(values: tuple[int, ...]):
    for size in range(len(values) + 1):
        yield from itertools.combinations(values, size)


def main() -> int:
    mismatches: list[tuple[int, ...]] = []
    sidon_count = 0
    checked = 0
    by_size: dict[int, dict[str, int]] = {}

    for subset in all_subsets(DOMAIN):
        checked += 1
        q = sidon_by_quadruples(subset)
        u = sidon_by_unordered_sums(subset)
        if q != u:
            mismatches.append(subset)
        if q:
            sidon_count += 1
        row = by_size.setdefault(len(subset), {"checked": 0, "sidon": 0})
        row["checked"] += 1
        row["sidon"] += int(q)

    controls = {
        "empty_is_sidon": sidon_by_quadruples(()),
        "singleton_is_sidon": sidon_by_quadruples((7,)),
        "zero_one_three_is_sidon": sidon_by_quadruples((0, 1, 3)),
        "zero_one_two_is_not_sidon": not sidon_by_quadruples((0, 1, 2)),
        "swapped_pair_is_allowed": sidon_by_quadruples((0, 1)),
        "weak_encoding_misses_double_collision": weak_sidon_excluding_doubles((0, 1, 2)),
        "ordered_encoding_rejects_swap": not too_strong_ordered_pair_sidon((0, 1)),
    }
    success = not mismatches and all(controls.values()) and checked == 2 ** len(DOMAIN)
    script_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    report = {
        "domain": list(DOMAIN),
        "scope": "every subset of the stated nine-element integer domain",
        "subsets_checked": checked,
        "sidon_subsets": sidon_count,
        "mismatches": [list(x) for x in mismatches],
        "by_size": by_size,
        "controls": controls,
        "script_sha256": script_hash,
        "success": success,
    }
    print(json.dumps(report, indent=2, sort_keys=True))
    return 0 if success else 1


if __name__ == "__main__":
    raise SystemExit(main())
