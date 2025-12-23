# safe_debouncer

A **safe, async-aware debouncer for Dart & Flutter** that prevents overlapping executions, timer leaks, and repeated boilerplate code.

`safe_debouncer` is a **logic-only** utility designed to handle one of the most common pain points in app development: **debouncing actions correctly**.

---

## ✨ Why safe_debouncer?

Most debounce implementations:
- leak `Timer`s
- break on rebuilds
- don’t handle async callbacks
- allow overlapping executions
- get re-written differently in every project

`safe_debouncer` solves this **once and for all**.

---

## 🚀 Features

- ✅ Supports **sync & async** callbacks
- ✅ Prevents **overlapping executions**
- ✅ Safe cancellation and disposal
- ✅ Rebuild-safe
- ✅ Key-based debouncing for multiple streams (`SafeDebouncerMap`)
- ✅ Individual debouncer instances (`SafeDebouncer`)
- ✅ Pure Dart (no Flutter dependency)
- ✅ Tiny, focused API

---

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  safe_debouncer: ^0.0.1
```

---

## 📚 Usage

### Basic Usage

```dart
import 'package:safe_debouncer/safe_debouncer.dart';

void main() {
  final debouncer = SafeDebouncer(Duration(milliseconds: 500));

  debouncer.call(() {
    print('Debounced action executed!');
  });
}
```

### Async Callbacks

```dart
import 'package:safe_debouncer/safe_debouncer.dart';

void main() async {
  final debouncer = SafeDebouncer(Duration(milliseconds: 500));

  await debouncer.callAsync(() async {
    print('Debounced async action executed!');
  });
}
```

### Key-based Debouncing

```dart
import 'package:safe_debouncer/safe_debouncer.dart';

void main() {
  final debouncerMap = SafeDebouncerMap(Duration(milliseconds: 500));

  debouncerMap.call('key1', () {
    print('Debounced action executed for key1!');
  });

  debouncerMap.call('key2', () {
    print('Debounced action executed for key2!');
  });
}
```

---

## 📖 API Reference

### `SafeDebouncer`

* `SafeDebouncer(Duration duration)`: Creates a new `SafeDebouncer` instance with the specified `duration`.
* `call(VoidCallback callback)`: Calls the `callback` after the specified `duration`.
* `callAsync(Future<void> Function() callback)`: Calls the `callback` after the specified `duration` and returns a `Future` that completes when the `callback` is executed.

### `SafeDebouncerMap`

* `SafeDebouncerMap(Duration duration)`: Creates a new `SafeDebouncerMap` instance with the specified `duration`.
* `call(String key, VoidCallback callback)`: Calls the `callback` after the specified `duration` for the specified `key`.
* `callAsync(String key, Future<void> Function() callback)`: Calls the `callback` after the specified `duration` for the specified `key` and returns a `Future` that completes when the `callback` is executed.
