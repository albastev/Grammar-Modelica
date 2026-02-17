# Grammar::Modelica

![Travis CI status](https://travis-ci.org/albastev/Grammar-Modelica.svg?branch=master)
![AppVeyor CI status](https://ci.appveyor.com/api/projects/status/dg9670t57kyohgwe/branch/master?svg=true)

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


