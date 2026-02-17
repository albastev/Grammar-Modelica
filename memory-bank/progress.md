# Progress: Grammar::Modelica

## Current status

Docker-based local testing and Docker-backed GitHub Actions CI have been added, and module packaging has been modernized to `.rakumod`.

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

## What remains

- Optionally pin `rakudo-star` to a specific version tag for stronger reproducibility.
- Optionally remove/retire legacy CI files (`.travis.yml`, `appveyor.yml`) once migration is fully validated.
- Continue parser modernization tasks from `projectbrief.md` (extensions, parser optimization, actions, metadata updates).

## Known issues

- Docker and CI changes were not executed in this session (files were updated, but container build/test runtime validation is still recommended in your environment).
- Runtime validation of the latest extension-migration change could not be executed in this session because `raku`, `prove`, and `make` were unavailable on PATH in the current shell.

## Recent evolution

- Migrated module files and `META6.json` mappings from deprecated `.pm6` usage to modern `.rakumod` usage to address deprecation warnings.
- Added first-class Docker workflow for local tests.
- Migrated active CI path to GitHub Actions using Docker-based execution.
