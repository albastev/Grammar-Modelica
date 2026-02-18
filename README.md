# Grammar::Modelica

[![CI](https://github.com/albastev/Grammar-Modelica/actions/workflows/ci.yml/badge.svg)](https://github.com/albastev/Grammar-Modelica/actions/workflows/ci.yml)

Raku grammar for parsing the [Modelica Language Specification](https://www.modelica.org/documents/ModelicaSpec34.pdf), based primarily on Appendix B concrete syntax rules.

## What this project provides

- A modular Modelica grammar under `lib/Grammar/Modelica*`
- Parsing support for key language areas (lexical conventions, expressions, equations, class definitions, etc.)
- Test suite in `t/` covering the main grammar components

## Quick start

```bash
zef install --deps-only .
```

Parse a snippet:

```bash
raku -Ilib -e "use Grammar::Modelica; say so Grammar::Modelica.parse('model A end A;')"
```

## Run tests

```bash
raku -Ilib t/Modelica.t
```

or run the full suite:

```bash
prove -e "raku -Ilib" -r t
```

## Docker workflow

Run tests in a container without installing Raku locally:

```bash
docker build --no-cache --progress=plain -t grammar-modelica-test . 2>&1

docker run --rm grammar-modelica-test 2>&1
```

Build and run the project test image:

```bash
docker build -t grammar-modelica-test .
docker run --rm grammar-modelica-test
```

If you have `make` available, convenience targets are provided:

```bash
make docker-build
make docker-test
make docker-shell
```

`docker-shell` mirrors your idea of launching an interactive Rakudo container, but pre-mounts this repository as `/app` so you can run commands directly against project files.

## Parse the Modelica Standard Library (MSL)

This repository includes [`examples/parseThemAll.p6`](examples/parseThemAll.p6), a bulk parser runner intended for full-library validation.

### What it does

- Recursively finds all `.mo` files under a directory
- Parses each file with [`Grammar::Modelica.parse(...)`](lib/Grammar/Modelica.rakumod)
- Prints `OK`, `FAIL`, or `ERROR` per file
- Prints a final summary line: `passed=<n> failed=<n> total=<n>`
- Exits with code `0` only when all files pass

### Local run against pinned MSL v4.0.0 (Docker)

```bash
git clone --depth 1 --branch v4.0.0 https://github.com/modelica/ModelicaStandardLibrary.git _deps/ModelicaStandardLibrary

docker build -t grammar-modelica-test .

docker run --rm \
  -v "$PWD:/app" \
  -w /app \
  grammar-modelica-test \
  raku -Ilib examples/parseThemAll.p6 _deps/ModelicaStandardLibrary | tee msl-parse.log
```

Windows `cmd.exe` variant:

```bat
if not exist _deps\ModelicaStandardLibrary\NUL git clone --depth 1 --branch v4.0.0 https://github.com/modelica/ModelicaStandardLibrary.git _deps\ModelicaStandardLibrary
docker build -t grammar-modelica-test .
docker run --rm -v "%cd%:/app" -w /app grammar-modelica-test raku -Ilib examples/parseThemAll.p6 _deps/ModelicaStandardLibrary > msl-parse.log 2>&1
```

If terminal streaming is unreliable, always inspect [`msl-parse.log`](msl-parse.log) for complete output.

## CI

CI is configured with **GitHub Actions** ([`.github/workflows/ci.yml`](.github/workflows/ci.yml)) and runs through Docker to keep local and CI execution paths aligned.

Current CI flow:

- Build Docker image
- Run regular test suite
- Clone Modelica Standard Library at pinned tag `v4.0.0`
- Run full MSL parse via [`examples/parseThemAll.p6`](examples/parseThemAll.p6)
- Upload parse log artifact (`msl-parse-log`) for diagnostics

## Repository layout

- `lib/Grammar/Modelica.rakumod` — top-level grammar entry point
- `lib/Grammar/Modelica/` — grammar modules by syntax domain
- `t/` — tests and regressions
- `examples/` — small parsing examples

## Current status

The project is stable and test-backed, with ongoing modernization work focused on:

- modern Raku conventions
- parser performance improvements
- richer parse actions / AST-oriented outputs
