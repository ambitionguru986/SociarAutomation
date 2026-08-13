# Dart Language Conventions

## 1. Naming

| Construct | Convention | Example |
|-----------|-----------|---------|
| Classes / Enums / Typedefs | `UpperCamelCase` | `AttendanceBloc`, `ServerFailure` |
| Variables / Parameters / Methods | `lowerCamelCase` | `submitAttendance`, `requestDate` |
| Constants | `lowerCamelCase` + `const` | `const checkIn = '09:00'` |
| Files | `snake_case` | `attendance_remote_data_source.dart` |
| Private members | `_` prefix | `_buildHeaders`, `_tokenController` |
| Acronyms > 2 chars | `UpperCamelCase` | `HttpClient` not `HTTPClient` |

**Checklist:**
- [ ] All class/enum/typedef names are `UpperCamelCase`
- [ ] All variables/methods/params are `lowerCamelCase`
- [ ] Constants declared with `const` keyword
- [ ] All file names are `snake_case.dart`
- [ ] Private members have `_` prefix
- [ ] No acronyms in ALL_CAPS beyond 2 characters

## 2. Type Safety

- [ ] All public and private methods have explicit return types declared
- [ ] `dynamic` is never used unless absolutely necessary with a comment explaining why
- [ ] Variables that are not reassigned are declared `final`
- [ ] Compile-time constant values use `const`
- [ ] `late` is used sparingly — prefer nullable types or default values
- [ ] No unsafe casting (`as T`) without a prior `is` check or safety comment
- [ ] No `// ignore:` suppression without a justification comment

## 3. Null Safety

- [ ] Types are non-nullable by default; nullable only when `null` carries semantic meaning
- [ ] Uses `?.`, `??`, `??=` instead of explicit null-check + assignment patterns
- [ ] Null assertion operator `!` is never used on values that could legitimately be null
- [ ] Dart 3 pattern matching (`if (x case SomeClass(:var field))`) used where appropriate
- [ ] No `late` that could throw `LateInitializationError` at runtime

## 4. Formatting & Style

- [ ] Line length never exceeds **80 characters**
- [ ] Code was run through `dart format .` (not hand-formatted)
- [ ] Multi-line parameter lists and collection literals have trailing commas
- [ ] Single quotes used for strings (double quotes only when string contains a single quote)
- [ ] Import order: `dart:*` → `package:flutter/*` → `package:*` → relative, each group blank-line separated
- [ ] No unused imports remain in the file

## 5. Effective Dart

- [ ] Functions with >= 2 parameters use named parameters where meaning is not obvious
- [ ] `=>` arrow syntax only for single-expression functions; block `{}` for multi-line
- [ ] No `print()` in production code — use `package:logger` or similar
- [ ] No `TODO`/`FIXME` comments without a linked ticket reference (e.g., `// TODO(AG-123): fix this`)
- [ ] No commented-out dead code left in the codebase
- [ ] Prefer `collection if` / `collection for` over imperative list building where readable
- [ ] Use `switch` expressions (Dart 3) for exhaustive matching on sealed classes/enums
