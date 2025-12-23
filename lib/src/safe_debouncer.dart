import 'dart:async';

typedef DebounceCallback = FutureOr<void> Function();

/// A safe debouncer that supports sync & async callbacks,
/// cancellation, and prevents overlapping executions.
class SafeDebouncer {
  final Duration delay;

  Timer? _timer;
  bool _isRunning = false;

  SafeDebouncer({required this.delay});

  /// Runs the callback after the debounce [delay].
  /// If called again before delay, the previous call is cancelled.
  void run(DebounceCallback callback) {
    _timer?.cancel();

    _timer = Timer(delay, () async {
      if (_isRunning) return;
      _isRunning = true;

      try {
        await callback();
      } finally {
        _isRunning = false;
      }
    });
  }

  /// Cancels any pending debounce.
  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  /// Dispose the debouncer (alias for cancel).
  void dispose() {
    cancel();
  }
}

/// A key-based debouncer for managing multiple debounce streams.
class SafeDebouncerMap {
  final Duration delay;
  final Map<String, SafeDebouncer> _map = {};

  SafeDebouncerMap({required this.delay});

  void run(String key, DebounceCallback callback) {
    _map.putIfAbsent(key, () => SafeDebouncer(delay: delay))
        .run(callback);
  }

  void cancel(String key) {
    _map[key]?.cancel();
    _map.remove(key);
  }

  void cancelAll() {
    for (final debouncer in _map.values) {
      debouncer.cancel();
    }
    _map.clear();
  }
}
