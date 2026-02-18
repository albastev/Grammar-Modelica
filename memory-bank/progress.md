# Progress: Grammar::Modelica

## Current status

Docker-based local testing and Docker-backed GitHub Actions CI are in place, module packaging has been modernized to `.rakumod`, and the grammar has now been aligned with key Modelica 3.6 concrete syntax updates.

## What works

- Raku module files under `lib/` now use `.rakumod` extensions instead of `.pm6`.
- `META6.json` `provides` entries now explicitly map all modules to `.rakumod` paths.
- README repository layout now references `lib/Grammar/Modelica.rakumod`.
- Docker test image support via `Dockerfile` and `.dockerignore`.
- Convenience commands via `Makefile` targets:
  - `docker-build`
  - `docker-test`
  - `docker-shell`
- GitHub Actions workflow (`.github/workflows/ci.yml`) that builds and runs tests in Docker.
- README documentation for Docker usage and CI status badge.
- Modelica 3.6 grammar alignment updates completed in parser code:
  - Added `description` / `description_string` productions.
  - Kept `comment` / `string_comment` as compatibility aliases.
  - Added `function_partial_application` and integrated it in function-argument grammar.
  - Updated `import_clause` to explicitly allow `name.*` / `name .*` form.
  - Updated class grammar rules to use `description` naming.
- Test coverage updated for 3.6-oriented behavior in:
  - `t/ClassDefinition.t`
  - `t/Expressions.t`
- Dockerized test suite currently passes:
  - `docker build --no-cache --progress=plain -t grammar-modelica-test .`
  - `docker run --rm grammar-modelica-test`

## What remains

- Optionally pin `rakudo-star` to a specific version tag for stronger reproducibility.
- Optionally remove/retire legacy CI files (`.travis.yml`, `appveyor.yml`) once migration is fully validated.
- Continue parser modernization tasks from `projectbrief.md` (extensions, parser optimization, actions, metadata updates).

## Known issues

- `raku`, `prove`, and `make` are still unavailable on PATH in the current shell; Docker remains the validated execution path in this environment.

## Recent evolution

- Migrated module files and `META6.json` mappings from deprecated `.pm6` usage to modern `.rakumod` usage to address deprecation warnings.
- Added first-class Docker workflow for local tests.
- Migrated active CI path to GitHub Actions using Docker-based execution.
- Synced implemented grammar portions from Modelica 3.4 to 3.6 concrete syntax for:
  - description/comment production naming,
  - function partial application production support,
  - explicit import wildcard tokenization (`.*`).
