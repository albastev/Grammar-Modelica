# Active Context: Modelica 3.6 Grammar Alignment (in progress)

## Current focus

Align parser productions from Modelica concrete syntax 3.4 to 3.6 for the implemented grammar surface, while preserving backward compatibility for existing tests/usages.

## Recently completed

- Modernized Raku module file extensions from `.pm6` to `.rakumod` under `lib/`.
- Updated `META6.json` `provides` mappings to explicitly point at `.rakumod` module files.
- Updated `README.md` repository layout documentation to reference `lib/Grammar/Modelica.rakumod`.
- Added Docker assets for local test workflows:
  - `Dockerfile` (Raku test image using `rakudo-star`)
  - `.dockerignore`
  - `Makefile` targets for `docker-build`, `docker-test`, and `docker-shell`
- Added GitHub Actions workflow at `.github/workflows/ci.yml` that builds the Docker image and runs tests in-container.
- Updated `README.md` with Docker usage, convenience targets, and CI documentation.
- Implemented targeted Modelica 3.6 grammar updates:
  - Added `description` / `description_string` productions in `lib/Grammar/Modelica/Expressions.rakumod`.
  - Kept `comment` / `string_comment` as backward-compatible aliases.
  - Added `function_partial_application` and integrated it into `function_argument` and `function_arguments`.
  - Updated `import_clause` in `lib/Grammar/Modelica/ClassDefinition.rakumod` to explicitly support `name .*` / `name.*` via `' .* '` alternative.
  - Migrated class-related rules in `ClassDefinition.rakumod` from `<comment>`/`<string_comment>` references to `<description>`/`<description_string>`.
  - Updated tests in `t/ClassDefinition.t` and `t/Expressions.t` to cover new 3.6 forms while preserving existing behavior checks.

## Active decisions

- Use Docker as the canonical execution environment for tests to reduce host/toolchain drift.
- Keep CI execution path aligned with local Docker execution by running tests from the same container image.
- Keep legacy CI config files in repo for now, but treat GitHub Actions as the active CI path.
- Prefer modern Raku module packaging conventions (`.rakumod`) to avoid deprecated extension warnings.
- Apply 3.6 updates incrementally with compatibility aliases to avoid broad breakage in downstream grammar modules/tests.
- Prioritize parser-level concrete syntax deltas (grammar productions) over semantic/spec clarification changes.

## Next steps

- Validate updated grammar/tests in an environment with `raku` + `prove` (or `make`/Docker CLI) available on PATH.
- If any failures surface, refine `function_arguments` ambiguity handling and update tests accordingly.
- Optionally pin a specific `rakudo-star` tag instead of `latest` for stronger reproducibility.
- Consider retiring legacy `.travis.yml` and `appveyor.yml` once migration is fully confirmed.
- Continue broader parser modernization tasks from `projectbrief.md` after 3.6 sync validation.
