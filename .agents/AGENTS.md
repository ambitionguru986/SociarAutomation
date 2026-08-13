# SociarAutomation — Agent Rules

## /code-review

When the user invokes `/code-review` or asks you to review or refactor Dart/Flutter code in this project, apply **every** section below as a checklist. For each violation found, cite the exact file + line, state the rule broken, and provide a corrected snippet.

---

## 1. Project Architecture (Clean Architecture + BLoC)

### 1.1 Layer Separation
- **Data layer** (`data/`) must never import from `presentation/`.
- **Domain layer** (`domain/`) must never import from `data/` or `presentation/`. It must only depend on its own entities, repositories (abstract), and usecases.
- **Presentation layer** (`presentation/`) may import domain usecases/entities only — never concrete data implementations.
- Repository interfaces live in `domain/repositories/`; implementations live in `data/repositories/`.
- Remote/local data sources live in `data/datasources/`; they must not be imported directly by blocs or usecases.

### 1.2 BLoC Conventions
- Events must be **immutable** (all fields `final`); use `const` constructors.
- States must extend a sealed base state and be immutable; override `props` in `Equatable`.
- BLoC must contain **zero** UI logic (no `BuildContext`, no navigation calls, no `showDialog`).
- Use `on<EventType>(handler)` registration, never `mapEventToState`.
- Emit at least one loading/running state before async operations so the UI can show progress.
- Always `await` futures inside event handlers; never fire-and-forget inside a bloc.
- Avoid emitting identical states — rely on `Equatable` props to deduplicate.

### 1.3 Use Cases
- Each use case handles exactly **one** action (Single Responsibility Principle).
- Params classes must be `Equatable` with all fields in `props`.
- Use cases return `Either<Failure, T>` (dartz) — never throw exceptions out of the domain layer.
- Mark use cases `@lazySingleton` or `@injectable` as appropriate; never instantiate them manually.

---

## 2. Dart Language Conventions

### 2.1 Naming
- **Classes / Enums / Typedefs**: `UpperCamelCase` — e.g., `AttendanceBloc`, `ServerFailure`.
- **Variables / Parameters / Methods**: `lowerCamelCase` — e.g., `submitAttendance`, `requestDate`.
- **Constants**: `lowerCamelCase` with `const` — e.g., `const checkIn = '09:00'`.
- **Files**: `snake_case` — e.g., `attendance_remote_data_source.dart`.
- **Private members**: prefix with `_` — e.g., `_buildHeaders`, `_tokenController`.
- Acronyms > 2 chars follow `UpperCamelCase` — `HttpClient`, not `HTTPClient`.

### 2.2 Type Safety
- Always declare explicit return types on public and private methods; avoid `dynamic`.
- Prefer `final` for variables that are not reassigned; use `const` wherever the value is compile-time constant.
- Use `late` sparingly; prefer nullable types or default values instead.
- Avoid casting (`as T`) without a preceding `is` check or a comment explaining why it is safe.
- Never suppress the analyzer with `// ignore:` without a justification comment.

### 2.3 Null Safety
- Prefer non-nullable types; only make a type nullable when `null` carries semantic meaning.
- Use `?.`, `??`, `??=` instead of null checks followed by explicit assignment.
- Never use the null-assertion operator `!` on values that could legitimately be null at runtime.
- Use `if (x case SomeClass(:var field))` pattern matching (Dart 3) where appropriate.

### 2.4 Formatting & Style
- Max line length: **80 characters** (matches `dart format` default).
- Use `dart format .` before committing — never hand-format.
- Trailing commas on multi-line parameter lists and collection literals to enable clean formatting.
- Prefer single quotes for strings; use double quotes only when the string itself contains a single quote.
- Organise imports: `dart:*` → `package:flutter/*` → `package:*` → relative imports, each group separated by a blank line.
- Remove unused imports immediately.

### 2.5 Effective Dart
- Prefer named parameters for functions with >= 2 parameters, or when parameter meaning is not obvious from context.
- Use `=>` (arrow) syntax only for single-expression functions; use block bodies for multi-line logic.
- Avoid `print()` in production code; use a proper logger (e.g., `package:logger`).
- Do not leave `TODO`/`FIXME` comments without a ticket reference.

---

## 3. Flutter UI Conventions

### 3.1 Widget Design
- Prefer **stateless** widgets whenever state is managed externally (BLoC/Provider).
- Break large `build()` methods into smaller private widget methods or dedicated widget classes.
- Never do expensive computation inside `build()` — precompute in state or use `didUpdateWidget`.
- Extract repeated `SizedBox(height: X)` / `SizedBox(width: X)` into named constants.
- Use `const` constructors for widgets and their children wherever possible — reduces rebuilds.

### 3.2 Layout
- Prefer `Flexible`/`Expanded` over hard-coded pixel widths for responsive layouts.
- Use `LayoutBuilder` + `MediaQuery` for screen-size-aware layouts.
- Avoid `Expanded` inside a `Column` that itself has unbounded height — causes layout overflow.
- Never nest `ListView` inside `Column` without wrapping the inner list in `Expanded` or `SizedBox` with fixed height.
- Use `SafeArea` at the root of each screen.

### 3.3 Performance
- Use `ListView.builder` / `GridView.builder` (lazy) instead of `ListView(children: [...])` for lists of unknown length.
- Avoid rebuilding the entire widget tree — use `BlocBuilder` with a `buildWhen` predicate.
- Use `RepaintBoundary` around complex animations or widgets that repaint frequently.
- Cache network images with `cached_network_image`; never use `Image.network` directly in lists.
- **Do not use `setState`**. Move all state logic to BLoC and use `BlocSelector` or `BlocBuilder` for targeted UI rebuilds.
- Use `AutomaticKeepAliveClientMixin` only for tabs that are expensive to rebuild.

### 3.4 Navigation
- Use a declarative router (`go_router`) for web-compatible navigation and deep linking.
- Never pass `BuildContext` across async gaps without first checking `mounted`.
- Pass only IDs between routes, not entire model objects, to avoid serialisation issues.

### 3.5 Accessibility
- Every interactive widget must have a `Semantics` label or leverage a widget that provides one.
- Minimum tap target: 48x48 logical pixels (`kMinInteractiveDimension`).
- Ensure sufficient colour contrast (WCAG AA: >= 4.5:1 for normal text).

---

## 4. Error Handling

- **Data layer**: catch `Exception`s, convert to `Failure` objects, return `Left(failure)`.
- **Domain layer**: never throw; always return `Either`.
- **Presentation layer**: pattern-match on `Either` or listen for error states; display user-friendly messages via `SnackBar` or inline widgets — never raw exception messages.
- Log errors with stack traces in data sources (use a structured logger, not `print`).
- For HTTP calls: explicitly handle `4xx` (client error) and `5xx` (server error) separately where behaviour differs.
- Set a request timeout (`client.get(...).timeout(Duration(...))`) to avoid hanging indefinitely.

---

## 5. Networking (HTTP / Multipart)

- Centralise base URL and common headers in one place (`_buildHeaders`) — never scatter raw strings.
- Use `http.MultipartRequest` for `multipart/form-data` — **never** set `content-type: application/json` on a multipart request.
- Always `await` the response, check status codes, and throw typed `ServerException` on failure.
- Add a request timeout (e.g., 30 s) on every network call.
- Avoid hardcoding auth tokens in source code; always accept them at runtime via constructor or param.
- Sanitise and validate all inputs before including them in a request body.

---

## 6. Dependency Injection (injectable / get_it)

- All classes registered with DI must have `@injectable`, `@lazySingleton`, or `@singleton` annotations — nothing should be constructed with `SomeClass()` directly in business logic.
- Run `dart run build_runner build --delete-conflicting-outputs` after any DI annotation change.
- Use `@factoryMethod` for factories; use `@preResolve` for async singletons.
- Never store a `GetIt` reference inside a domain or data class — inject dependencies through the constructor.

---

## 7. State Management (BLoC Specific)

- States should carry all data needed by the UI — avoid having the UI reach into other services.
- Use `BlocConsumer` only when you need both `listen` (side effects) and `builder` (UI rebuild); use `BlocBuilder` alone when there are no side effects.
- Move all state logic into the BLoC and use `BlocSelector` to subscribe to a sub-field of state, avoiding full rebuilds and completely removing the need for `setState`.
- Close `StreamSubscription`s and other resources in `close()` override of the BLoC.
- States must be created using `freezed` with union types (`@freezed`).
- Keep state classes sealed using freezed so new states force UI update handling via `.when()` or `.map()`.

---

## 8. Testing Standards

- Unit test every use case with mocked repository (`mockito` or `mocktail`).
- Widget test every screen for at least the happy path and the error state.
- BLoC tests use `bloc_test` package with `act` / `expect` pattern.
- Aim for > 80% line coverage on `domain/` and `data/` layers.
- Do not test implementation details; test observable behaviour (state transitions, UI text).

---

## 9. Code Quality Gates

Before considering any PR/review complete, verify:

| Check | Tool |
|---|---|
| No analysis issues | `flutter analyze` (must be 0 errors, 0 warnings) |
| Formatted | `dart format --set-exit-if-changed .` |
| All tests pass | `flutter test` |
| No dead code | `dart fix --dry-run` shows no fixes |
| Dependency health | `flutter pub outdated` — address critical upgrades |

---

## 10. Security

- Never commit Bearer tokens, API keys, or secrets; use `.env` / `--dart-define` / secure storage.
- Validate and sanitise all user-supplied strings before embedding in requests.
- Use HTTPS exclusively; never allow `http://` URIs in production code.
- Store sensitive data (tokens) in `flutter_secure_storage`, not `shared_preferences`.
- Avoid logging sensitive fields (tokens, passwords) even at debug level.

---

## 11. Performance Optimization Checklist

- [ ] Use `const` on every widget and constructor that qualifies.
- [ ] Replace `setState` hot paths with BLoC/Riverpod so only affected subtrees rebuild.
- [ ] Prefer `StreamBuilder` with `distinct()` or `BlocSelector` to avoid redundant rebuilds.
- [ ] Avoid allocating objects inside `build()` — move to `initState` or class level.
- [ ] Use `compute()` or `Isolate.run()` for CPU-intensive parsing (JSON, regex on large text).
- [ ] Debounce text-field listeners rather than reacting on every keystroke.
- [ ] Use `precacheImage()` in `initState` for images shown on the next screen.
- [ ] Profile with Flutter DevTools before and after optimization — never guess.
- [ ] Avoid `Opacity` widget for animations; use `FadeTransition` (cheaper, GPU-composited).
- [ ] Minimize `saveLayer()` calls — avoid `BoxShadow` on frequently repainting widgets.

---

*This rule is automatically loaded for every agent session in this workspace.*
