# opensim-stack-docs

Documentation suite for the OpenSim AI Docker stack and related components.

## Local setup

```bash
python3 -m venv .venv

source .venv/bin/activate

pip install -r requirements.txt
```

## Run locally

```bash
source .venv/bin/activate

mkdocs serve
```

## Build static site (local site/)

```bash
source .venv/bin/activate

mkdocs build
```

## Publish build into GitHub Pages repo

`build.sh` builds this docs site and writes it into `../opensim-stack.github.io/docs`.

```bash
./build.sh
```