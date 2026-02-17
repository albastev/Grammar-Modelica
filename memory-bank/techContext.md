# Tech Context: Grammar::Modelica

## Technologies in use

- **Language:** Raku (historically Perl 6 naming in parts of the repo)
- **Core implementation:** Raku grammars and regex-based parsing
- **Package metadata:** `META6.json`
- **Testing:** Raku `Test` files under `t/`

## Current repository conventions

- Main library files currently use `.pm6` extensions.
- Grammar is split across multiple files in `lib/Grammar/Modelica/`.
- CI config exists (`.travis.yml`, `appveyor.yml`).

## Development workflow expectations

- Run tests to validate parser behavior after changes.
- Keep grammar updates aligned with Modelica spec references.
- Maintain compatibility expectations while modernizing toward current Raku practices.

## Constraints and considerations

- Grammar correctness is primary; performance tuning should preserve semantics.
- Backward compatibility may matter for existing consumers.
- Modernization should be incremental with regression coverage.
