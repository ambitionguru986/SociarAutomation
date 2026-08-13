# Quality Gates & Security

## 1. Quality Gates

Run ALL of the following before marking a review or PR complete:

| Gate | Command | Pass Criteria |
|------|---------|---------------|
| Static analysis | `flutter analyze` | 0 errors, 0 warnings |
| Formatting | `dart format --set-exit-if-changed .` | Exit code 0 |
| Tests | `flutter test` | All tests pass |
| Dead code | `dart fix --dry-run` | No fixes suggested |
| Dependency health | `flutter pub outdated` | No critical upgrades outstanding |

### How to run them together
```bash
dart format --set-exit-if-changed . && \
flutter analyze && \
flutter test && \
dart fix --dry-run
```

## 2. Testing Standards

### Unit Tests
- [ ] Every use case has unit tests with mocked repository (`mockito` or `mocktail`)
- [ ] Every data source method has unit tests with mocked `http.Client`
- [ ] `@GenerateMocks([...])` + `build_runner` used to generate mocks — never manual stubs

### BLoC Tests
- [ ] Every BLoC uses `bloc_test` package with `act` / `expect` / `verify` pattern
- [ ] Both happy path and error path covered for every event handler
- [ ] `seed` used in `blocTest` when testing state transitions that depend on prior state

### Widget Tests
- [ ] Every screen has at minimum: happy path render test + error state render test
- [ ] `find.byKey` used with stable `Key`s for reliable element lookup
- [ ] `tester.pump()` / `tester.pumpAndSettle()` called after async operations

### Coverage Targets
- [ ] `domain/` layer: > 80% line coverage
- [ ] `data/` layer: > 80% line coverage
- [ ] `presentation/` layer: > 60% line coverage (UI is harder to test exhaustively)

## 3. Security Checklist

### Secrets & Credentials
- [ ] No Bearer tokens, API keys, or secrets committed to source control
- [ ] Secrets injected at build time via `--dart-define=KEY=VALUE` or loaded from secure storage
- [ ] `.env` files added to `.gitignore`
- [ ] `flutter_secure_storage` used for tokens — never `shared_preferences` for sensitive data

### Network Security
- [ ] All API calls use HTTPS — no plain `http://` URIs in production code
- [ ] SSL pinning considered for highly sensitive endpoints
- [ ] All user-supplied strings validated and sanitised before embedding in requests
- [ ] No sensitive data (tokens, passwords, PII) appears in log output

### Data Storage
- [ ] Sensitive data stored in `flutter_secure_storage` (uses Keychain on iOS, Keystore on Android)
- [ ] `shared_preferences` used only for non-sensitive user preferences (theme, language)
- [ ] No plaintext files written to external storage with sensitive content

### Code Integrity
- [ ] Obfuscation enabled for release builds: `flutter build apk --obfuscate --split-debug-info=...`
- [ ] `dart:mirrors` not used (prevents tree-shaking and exposes internals)
- [ ] No `eval`-equivalent dynamic code execution

## 4. Dependency Health

- [ ] Run `flutter pub outdated` and address packages with breaking upgrades
- [ ] No packages with known security vulnerabilities (check pub.dev advisories)
- [ ] Dev-only packages (test, build_runner) not listed under `dependencies` — must be `dev_dependencies`
- [ ] Transitive dependency conflicts resolved without version overrides where possible
