# Progress: Grammar::Modelica

## Current status

Docker-based local testing and Docker-backed GitHub Actions CI have been added.

## What works

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

## Recent evolution

- Added first-class Docker workflow for local tests.
- Migrated active CI path to GitHub Actions using Docker-based execution.
