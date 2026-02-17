# System Patterns: Grammar::Modelica

## Architecture Overview

The repository is organized as a modular Raku grammar package:

- `lib/Grammar/Modelica.pm6` as the top-level grammar entry point.
- Feature-specific grammar modules under `lib/Grammar/Modelica/` (e.g., expressions, equations, lexical conventions).
- Tests under `t/` aligned to grammar areas.

## Key Design Patterns in Use

- **Composable grammar modules:** syntax areas are separated into focused units.
- **Spec-driven implementation:** grammar rules follow Modelica specification syntax definitions.
- **Test-per-domain structure:** dedicated test files for major syntax domains.

## Emerging / Planned Patterns

- Introduce Action classes to transform parse trees into AST structures.
- Prefer lower-backtracking constructs (`token`/`rule`, proto-based dispatch) where appropriate for performance.
- Improve error reporting at grammar/action boundaries for Modelica-specific diagnostics.

## Critical Implementation Paths

- Lexical + expression parsing are foundational for most higher-level constructs.
- Class/component/equation parsing composes on top of lexical and expression rules.
- Regression tests should guard parser behavior while modernization proceeds.
