# Flutter UI Conventions

## 1. Widget Design

- [ ] Prefer **StatelessWidget** whenever state is managed externally (BLoC/Provider/Riverpod)
- [ ] Large `build()` methods broken into smaller private widget methods or separate widget classes
- [ ] No expensive computation inside `build()` — precompute in `initState`, `didUpdateWidget`, or state class
- [ ] Repeated spacing extracted to named constants (e.g., `static const _kSpacing = 16.0`)
- [ ] `const` constructors used on widgets and children wherever possible — eliminates unnecessary rebuilds
- [ ] No anonymous functions created inline in `build()` for callbacks that will cause rebuilds

## 2. Layout Rules

- [ ] `Flexible`/`Expanded` preferred over hard-coded pixel widths for responsive layouts
- [ ] `LayoutBuilder` + `MediaQuery` used for screen-size-aware layouts
- [ ] No `Expanded` inside a `Column` with unbounded height (causes RenderFlex overflow)
- [ ] No `ListView` nested inside `Column` without `Expanded` or a fixed-height `SizedBox`
- [ ] `SafeArea` wraps the root of each screen
- [ ] No `Scaffold` nested inside another `Scaffold`
- [ ] `IntrinsicHeight`/`IntrinsicWidth` avoided in performance-critical paths (expensive layout)

## 3. State & Rebuild Optimization

- [ ] `BlocBuilder` uses `buildWhen` predicate to prevent unnecessary rebuilds
- [ ] `BlocSelector` used to subscribe to sub-fields of state instead of the whole state
- [ ] `BlocConsumer` used only when BOTH side effects (listen) AND rebuilds (builder) are needed
- [ ] `setState` never called in deeply nested widgets — lift state to appropriate bloc/provider
- [ ] `AutomaticKeepAliveClientMixin` used only for tabs with expensive rebuild cost

## 4. List & Grid Performance

- [ ] `ListView.builder` / `GridView.builder` used for lists of unknown or large length
- [ ] `ListView(children: [...])` only acceptable for short, fixed-length lists (< ~10 items)
- [ ] `SliverList` / `SliverGrid` used inside `CustomScrollView` for complex scrollable UIs
- [ ] `itemExtent` or `prototypeItem` set on `ListView.builder` when all items are same height

## 5. Images & Media

- [ ] Network images use `cached_network_image` package — never bare `Image.network` in lists
- [ ] `precacheImage()` called in `initState` for images shown on the next screen
- [ ] `Image.asset` uses `cacheWidth`/`cacheHeight` to avoid decoding oversized images

## 6. Animations

- [ ] `FadeTransition` used instead of `Opacity` widget for opacity animations (GPU-composited)
- [ ] `AnimatedBuilder` / `AnimatedWidget` used instead of `setState`-driven animation loops
- [ ] `RepaintBoundary` wraps complex/frequently repainting widgets
- [ ] `saveLayer()` calls minimized — avoid `BoxShadow` and `ColorFilter` on frequently repainting widgets
- [ ] `AnimationController` disposed in `dispose()` override

## 7. Navigation

- [ ] `go_router` used for declarative, URL-based navigation and deep linking
- [ ] `BuildContext` never passed across async gaps without checking `mounted` first
- [ ] Only IDs (not full model objects) passed between routes
- [ ] No hardcoded route strings scattered across files — use route constants

## 8. Accessibility

- [ ] Every interactive widget has a `Semantics` label or inherits one from a Material widget
- [ ] Tap targets are minimum 48×48 logical pixels (`kMinInteractiveDimension`)
- [ ] Colour contrast meets WCAG AA standard (>= 4.5:1 for normal text, >= 3:1 for large text)
- [ ] `ExcludeSemantics` used only where the element is genuinely decorative
