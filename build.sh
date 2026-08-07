#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${SCRIPT_DIR}/../opensim-stack.github.io/docs"

cd "${SCRIPT_DIR}"

if [[ ! -d ".venv" ]]; then
  python3 -m venv .venv
fi

# shellcheck disable=SC1091
source .venv/bin/activate

python -m pip install --upgrade pip >/dev/null
python -m pip install -r requirements.txt >/dev/null

mkdir -p "${TARGET_DIR}"

mkdocs build --clean -d "${TARGET_DIR}"

echo "Docs built to ${TARGET_DIR}"
