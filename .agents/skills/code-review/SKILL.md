---
name: code-review
description: >
  Perform a comprehensive Flutter/Dart code review and refactor using
  Clean Architecture, BLoC, industry-standard Dart conventions, and
  performance optimization guidelines. Triggers on "/code-review",
  "review this code", "refactor for code quality", or any request to
  audit Flutter/Dart files for correctness, style, or performance.
---

# Code Review Skill

## How to Execute This Skill

1. **Identify scope** — determine which files/directories to review (open file, feature folder, or entire `lib/`).
2. **Read reference docs** — load each file in `references/` before starting the review.
3. **Run static analysis first** — always run `flutter analyze` and capture its output.
4. **Apply every checklist** — go section by section through the references. For each violation:
   - Cite the exact **file path + line number**
   - State the **rule broken** (section + bullet)
   - Provide a **corrected snippet** as a diff or code block
5. **Produce the report** — write findings to an artifact `code_review_report.md`.
6. **Apply fixes** — after user approval, apply all fixes and re-run `flutter analyze` to confirm 0 issues.
7. **Verify** — run `flutter test` to ensure nothing is broken.

## References (load all before reviewing)

- [Architecture & BLoC rules](references/architecture.md)
- [Dart language conventions](references/dart_conventions.md)
- [Flutter UI conventions](references/flutter_ui.md)
- [Error handling & networking](references/error_handling_networking.md)
- [Performance optimization checklist](references/performance_optimization.md)
- [Quality gates & security](references/quality_gates.md)

## Report Template

For each file reviewed, produce a table:

| # | File | Line | Rule Violated | Severity | Fix |
|---|------|------|---------------|----------|-----|
| 1 | `foo.dart` | 42 | 2.1 Naming — class should be UpperCamelCase | ⚠️ Warning | `class Foo` → `class FooService` |

Severity levels:
- 🔴 **Error** — compilation failure or runtime crash risk
- 🟠 **Critical** — architecture violation or security issue
- ⚠️ **Warning** — convention or style violation
- 💡 **Info** — optimization opportunity

## Constraints

- Never modify files until the user explicitly approves the report.
- Keep the report artifact updated as you discover issues — do not batch everything at the end.
- If `flutter analyze` already catches an issue, reference it but do not duplicate detail.
