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
docker run --rm -v "$PWD:/app" -w /app rakudo-star:latest prove -e "raku -Ilib" -r t
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

## CI

CI is configured with **GitHub Actions** (`.github/workflows/ci.yml`) and runs the test suite through the Docker image to keep local and CI execution paths aligned.

## Repository layout

- `lib/Grammar/Modelica.pm6` — top-level grammar entry point
- `lib/Grammar/Modelica/` — grammar modules by syntax domain
- `t/` — tests and regressions
- `examples/` — small parsing examples

## Current status

The project is stable and test-backed, with ongoing modernization work focused on:

- modern Raku conventions
- parser performance improvements
- richer parse actions / AST-oriented outputs
