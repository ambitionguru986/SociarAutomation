# Performance Optimization Checklist

## 1. Widget Rebuild Reduction

- [ ] `const` used on every widget constructor that qualifies
- [ ] `BlocSelector` used to subscribe only to the sub-field(s) of state the widget needs
- [ ] `buildWhen` predicate set on `BlocBuilder` to skip rebuilds when irrelevant state changes
- [ ] No anonymous lambdas or new object allocations inside `build()` — move to `initState` or class level
- [ ] `StatefulWidget` not used where `StatelessWidget` + external state is sufficient
- [ ] `setState` hot paths replaced with BLoC/Riverpod so only affected subtrees rebuild

## 2. Async & Compute

- [ ] CPU-intensive work (JSON parsing, regex on large strings, image processing) offloaded with `compute()` or `Isolate.run()`
- [ ] Text-field listeners debounced (e.g., 300–500 ms) rather than reacting on every keystroke
- [ ] Heavy `Future`s not `await`-ed in `build()` — use `FutureBuilder` or preload in `initState`
- [ ] `Stream`s used with `distinct()` or `BlocSelector` to filter redundant events before building

## 3. List & Scroll Performance

- [ ] Lazy builders (`ListView.builder`, `GridView.builder`, `SliverList`) used for all variable-length lists
- [ ] `itemExtent` or `prototypeItem` set on list builders where item height is uniform
- [ ] `addAutomaticKeepAlives: false` and `addRepaintBoundaries: false` set on list builders when items are simple

## 4. Image & Asset Performance

- [ ] `cached_network_image` used for all network images
- [ ] `Image.asset` calls include `cacheWidth`/`cacheHeight` for oversized source assets
- [ ] `precacheImage()` called in `initState` for images needed on the next screen
- [ ] SVGs rendered with `flutter_svg` not as raster assets where possible (resolution-independent)

## 5. Render Pipeline

- [ ] `Opacity` widget never used for animations — use `FadeTransition` (GPU-composited, cheaper)
- [ ] `RepaintBoundary` wraps widgets that animate or repaint independently of parent
- [ ] `BoxShadow` and `ColorFilter` not placed on widgets that repaint frequently (triggers `saveLayer`)
- [ ] `ClipRRect` / `ClipPath` minimized — these also trigger `saveLayer`
- [ ] `CustomPainter` implementations override `shouldRepaint` to return `false` when nothing changed

## 6. Memory Management

- [ ] All `TextEditingController`, `ScrollController`, `AnimationController`, and `FocusNode` disposed in `dispose()`
- [ ] All `StreamSubscription`s cancelled in `dispose()` or BLoC `close()`
- [ ] `GlobalKey` used sparingly — keeping keys alive prevents garbage collection of subtrees
- [ ] Images not held in memory longer than necessary — avoid storing `ImageProvider` in state

## 7. DevTools Workflow

- [ ] Profile with Flutter DevTools **before** and **after** any optimization — never guess
- [ ] Use the **Widget Rebuild Tracker** to confirm rebuilds are eliminated
- [ ] Use the **CPU Profiler** to confirm compute offloading is effective
- [ ] Use the **Memory tab** to check for memory leaks after dispose fixes
- [ ] Target: < 16 ms frame time (60 fps) / < 8 ms frame time (120 fps on ProMotion displays)

## 8. Build-Time Optimization

- [ ] `dart compile` / `flutter build --release` used for production — never ship debug builds
- [ ] Tree-shaking effective: no unused packages imported (check `flutter pub deps` for transitive bloat)
- [ ] `deferred as` used for rarely-accessed heavy libraries to enable deferred loading on web
