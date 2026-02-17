# Product Context: Grammar::Modelica

## Why this project exists

`Grammar::Modelica` provides a parser for the Modelica language using Raku grammar facilities. It exists to make Modelica source code machine-readable for validation, analysis, and downstream tooling.

## Problems it solves

- Converts Modelica source text into structured parse results.
- Encodes Appendix B grammar rules from the Modelica spec in executable form.
- Gives Raku users a reusable language grammar component for Modelica processing.

## Desired user experience

- Users can parse Modelica snippets/files reliably with a straightforward API.
- Grammar behavior should be predictable and close to official syntax rules.
- Parse failures should be understandable and actionable.
- Test coverage should make refactoring safe.

## Current product direction

Based on the project brief, modernization work is expected to focus on:

- Updating to modern Raku ecosystem conventions.
- Improving parse performance and maintainability.
- Adding Action classes for AST-oriented outputs.
- Preparing for broader Modelica version support.
