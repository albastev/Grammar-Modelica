# Project Brief: Grammar-Modelica Modernization

## 1. Project Overview

* **Repository:** [albastev/Grammar-Modelica]()
* **Original Scope:** A Raku grammar for the Modelica Language Specification 3.4.
* **Current Goal:** Refactor the grammar to "Modern Raku" (6.d+) to improve parsing efficiency, add comprehensive Action classes for AST generation, and update metadata for the current Raku ecosystem (Zef).

## 2. Technical Objectives

* **Language Standards:** Target **Modelica 3.6+** (the latest stable specifications) while maintaining backward compatibility where possible.
* **Modern Raku Syntax:**
* Transition from `perl6` to `raku` file extensions (`.rakumod`, `.t6`).
* Update `META6.json` to the current distribution standard.


* **Performance Optimization:** * Review backtracking regexes (`regex`) and convert to non-backtracking `token` or `rule` where possible.
* Use `proto` regexes for keyword-heavy rules (like `statement` or `class-definition`) to take advantage of Raku's Longest Token Matching (LTM).



## 3. Key Features to Implement

### A. Full Action Class Implementation

The original repo is primarily the grammar. The modernization will add a robust `Action` class that:

* Reduces the raw match object into a clean **Abstract Syntax Tree (AST)**.
* Handles Modelica's specific scoping rules (e.g., `within` clauses and `package` hierarchies).

### B. "Modelica-native" Error Handling

Replace generic parse failures with custom exceptions.

* Implement `die` or `fail` calls within the grammar/actions to provide specific line/column information and expected Modelica tokens.

### C. Comprehensive Testing Suite

* Migrate to `Test::Async` or utilize standard `Test` with modernized subtests.
* Incorporate the **Modelica Standard Library (MSL)** as a benchmark suite to ensure the grammar can handle real-world, large-scale models.

## 4. Modernization Checklist

| Task | Status | Notes |
| --- | --- | --- |
| **Rename Extensions** | ⬜ Pending | Change `.pm6` to `.rakumod`. |
| **LTM Optimization** | ⬜ Pending | Use `proto token` for Modelica keywords. |
| **AST Generation** | ⬜ Pending | Create `Grammar::Modelica::Actions`. |
| **Zef Distribution** | ⬜ Pending | Update `META6.json` for `zef` compatibility. |
| **Modelica 3.6 Sync** | ⬜ Pending | Review Appendix B of the latest spec. |

## 5. Potential Challenges

* **Complexity of Expression Rules:** Modelica expressions can be deeply nested. Ensuring the grammar doesn't hit recursion limits or performance bottlenecks on large `.mo` files is a priority.
* **Whitespace Handling:** Modelica allows for specific comment styles and significant/insignificant whitespace that must be handled carefully using Raku's `<.ws>` token.

---

### Suggested Directory Structure

```text
Grammar-Modelica/
├── lib/
│   └── Grammar/
│       ├── Modelica.rakumod      # The Grammar
│       └── Modelica/
│           └── Actions.rakumod   # AST Construction
├── t/
│   ├── 01-basic.t                # Sanity checks
│   └── 02-msl-compliance.t       # Tests against MSL
├── resources/                    # Sample .mo files
├── META6.json
└── README.md

```

## 6. Getting Started (For Contributors)

To run the modernized grammar locally:

```bash
zef install --deps-only .
raku -Ilib -e 'use Grammar::Modelica; say Grammar::Modelica.parsefile("path/to/model.mo")'

```