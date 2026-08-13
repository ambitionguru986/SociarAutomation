# Architecture & BLoC Rules

## 1. Clean Architecture Layer Separation

| Layer | Allowed imports | Forbidden imports |
|-------|----------------|-------------------|
| `data/` | `domain/entities`, `domain/repositories` (abstract), external packages | `presentation/` |
| `domain/` | Own entities, own repository interfaces, own usecases | `data/`, `presentation/` |
| `presentation/` | `domain/usecases`, `domain/entities` | `data/` concrete classes |

**Checklist:**
- [ ] No `data/` file imports anything from `presentation/`
- [ ] No `domain/` file imports anything from `data/` or `presentation/`
- [ ] Repository interfaces are in `domain/repositories/` only
- [ ] Repository implementations are in `data/repositories/` only
- [ ] Data sources (`data/datasources/`) are NOT imported directly by blocs or usecases

## 2. BLoC Conventions

- [ ] Every event class has all fields `final` and uses a `const` constructor
- [ ] Every state extends a sealed base and overrides `props` via `Equatable`
- [ ] BLoC contains zero UI logic — no `BuildContext`, no `Navigator`, no `showDialog`
- [ ] Event handlers use `on<EventType>(handler)` — never `mapEventToState`
- [ ] At least one loading/running state is emitted before every async operation
- [ ] All futures inside event handlers are `await`-ed; no fire-and-forget
- [ ] Identical states are NOT emitted back-to-back (rely on `Equatable` to deduplicate)
- [ ] `StreamSubscription`s and resources are closed in `close()` override

## 3. Use Case Rules

- [ ] Each use case handles exactly ONE action (Single Responsibility Principle)
- [ ] Params classes implement `Equatable` with all fields in `props`
- [ ] Use cases return `Either<Failure, T>` — never throw exceptions out of domain
- [ ] Use cases are annotated `@lazySingleton` or `@injectable`; never manually instantiated
- [ ] Use cases never depend on concrete data implementations — only abstract repositories

## 4. Dependency Injection

- [ ] All classes in DI graph carry `@injectable`, `@lazySingleton`, or `@singleton`
- [ ] No `SomeClass()` direct construction in business logic or blocs
- [ ] `build_runner` is re-run after every annotation change: `dart run build_runner build --delete-conflicting-outputs`
- [ ] `@factoryMethod` used for factories; `@preResolve` for async singletons
- [ ] `GetIt` reference is NEVER stored inside domain or data classes
