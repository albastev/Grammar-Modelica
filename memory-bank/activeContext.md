# Active Context: Dockerized Test Workflow + CI Migration

## Current focus

Standardize local and CI test execution via Docker, and migrate active CI to GitHub Actions.

## Recently completed

- Added Docker assets for local test workflows:
  - `Dockerfile` (Raku test image using `rakudo-star`)
  - `.dockerignore`
  - `Makefile` targets for `docker-build`, `docker-test`, and `docker-shell`
- Added GitHub Actions workflow at `.github/workflows/ci.yml` that builds the Docker image and runs tests in-container.
- Updated `README.md` with Docker usage, convenience targets, and CI documentation.

## Active decisions

- Use Docker as the canonical execution environment for tests to reduce host/toolchain drift.
- Keep CI execution path aligned with local Docker execution by running tests from the same container image.
- Keep legacy CI config files in repo for now, but treat GitHub Actions as the active CI path.

## Next steps

- Optionally pin a specific `rakudo-star` tag instead of `latest` for stronger reproducibility.
- Consider retiring legacy `.travis.yml` and `appveyor.yml` once migration is fully confirmed.
- Continue parser modernization tasks from `projectbrief.md` with Dockerized test validation.
