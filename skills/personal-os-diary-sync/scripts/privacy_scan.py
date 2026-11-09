#!/usr/bin/env python3
"""Conservative text scan for identifiers and secrets before publication."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


SKIP_DIRS = {".git", "__pycache__", ".venv", "node_modules"}
TEXT_SUFFIXES = {
    "", ".md", ".txt", ".py", ".json", ".jsonl", ".yaml", ".yml",
    ".toml", ".ini", ".cfg", ".ps1", ".sh", ".js", ".ts", ".csv",
}

PATTERNS = {
    "chatgpt_project_id": re.compile(r"\bg-p-[0-9a-f]{20,}\b", re.I),
    "google_workspace_url": re.compile(
        r"https?://(?:docs|drive)\.google\.com/[^\s)>\]]+", re.I
    ),
    "windows_user_path": re.compile(r"\b[A-Za-z]:\\Users\\[^\\\s]+", re.I),
    "absolute_windows_path": re.compile(r"\b[A-Za-z]:\\(?!<)[^\r\n`]+"),
    "email_address": re.compile(
        r"\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b", re.I
    ),
    "secret_assignment": re.compile(
        r"(?i)\b(api[_-]?key|access[_-]?token|refresh[_-]?token|client[_-]?secret|password)\b"
        r"\s*[:=]\s*['\"]?(?!<|example|changeme|redacted)[A-Za-z0-9_./+=-]{8,}"
    ),
}


def iter_text_files(root: Path):
    for path in root.rglob("*"):
        if not path.is_file() or any(part in SKIP_DIRS for part in path.parts):
            continue
        if path.suffix.lower() in TEXT_SUFFIXES:
            yield path


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("root", nargs="?", default=".", help="repository root")
    args = parser.parse_args()
    root = Path(args.root).resolve()
    findings: list[tuple[Path, int, str, str]] = []

    for path in iter_text_files(root):
        try:
            text = path.read_text(encoding="utf-8")
        except (UnicodeDecodeError, OSError):
            continue
        for line_number, line in enumerate(text.splitlines(), start=1):
            for name, pattern in PATTERNS.items():
                match = pattern.search(line)
                if match:
                    findings.append((path, line_number, name, match.group(0)))

    if findings:
        print("PRIVACY SCAN FAILED")
        for path, line_number, name, value in findings:
            relative = path.relative_to(root)
            print(f"{relative}:{line_number}: {name}: {value[:120]}")
        print(f"Findings: {len(findings)}")
        return 1

    print(f"PRIVACY SCAN PASSED: {root}")
    return 0


if __name__ == "__main__":
    sys.exit(main())


