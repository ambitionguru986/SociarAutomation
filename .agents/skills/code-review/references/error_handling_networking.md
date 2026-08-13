# Error Handling & Networking Rules

## 1. Error Handling — By Layer

### Data Layer (`data/`)
- [ ] All `Exception`s are caught and converted to typed `Failure` objects
- [ ] Returns `Left(failure)` — never re-throws raw exceptions upward
- [ ] Errors are logged with stack traces using a structured logger (not `print`)
- [ ] `ServerException` and `CacheException` are the two allowed exception types
- [ ] `4xx` client errors and `5xx` server errors handled separately where behaviour differs

### Domain Layer (`domain/`)
- [ ] Never throws — always returns `Either<Failure, T>`
- [ ] `Failure` subclasses (`ServerFailure`, `CacheFailure`) used consistently
- [ ] No try/catch in use cases — exception handling belongs in the data layer

### Presentation Layer (`presentation/`)
- [ ] Pattern-matches on `Either` or listens for error states — never accesses raw exception
- [ ] Displays user-friendly error messages via `SnackBar`, inline text, or dialog
- [ ] Never shows raw `Exception.toString()` to the user
- [ ] Error state triggers UI update (red text, retry button) — not just a log

## 2. HTTP Networking

### Request Construction
- [ ] Base URL is a single constant — never scattered as raw strings across files
- [ ] Common headers centralised in `_buildHeaders(token)` method
- [ ] `http.MultipartRequest` used for `multipart/form-data` requests
- [ ] `content-type: application/json` is NEVER set on a multipart request
- [ ] All user-supplied inputs sanitised and validated before embedding in request body

### Response Handling
- [ ] Every network call is `await`-ed — no fire-and-forget HTTP requests
- [ ] Status codes checked after every call; non-2xx throws typed `ServerException`
- [ ] `4xx` (client errors) and `5xx` (server errors) handled separately where needed
- [ ] Response body is not assumed to be valid JSON without a try/catch around `jsonDecode`

### Timeouts
- [ ] Every network call has an explicit timeout:
  ```dart
  await client.get(uri, headers: headers)
      .timeout(const Duration(seconds: 30));
  ```
- [ ] `TimeoutException` caught and converted to `ServerFailure`

### Auth & Secrets
- [ ] Bearer tokens accepted at runtime via constructor/parameter — never hardcoded
- [ ] No API keys or secrets in source files — use `--dart-define` or `flutter_secure_storage`
- [ ] Tokens not logged even at debug level

## 3. Multipart / File Upload (Project-Specific Pattern)

> **KI:** `getResponse` always sets `content-type: application/json`, which corrupts FormData.
> Always use `http.MultipartRequest` directly — never wrap multipart in a generic `getResponse` helper.

- [ ] `http.MultipartRequest('POST', uri)` used for all form-data submissions
- [ ] `request.headers.addAll(_buildHeaders(token))` called — NOT setting content-type manually
- [ ] `client.send(request)` used, then `http.Response.fromStream(streamedResponse)`
- [ ] Status code checked on the resulting `Response` object
