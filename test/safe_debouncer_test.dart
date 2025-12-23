import 'package:flutter_test/flutter_test.dart';
import 'package:safe_debouncer/safe_debouncer.dart';

void main() {
  test('debounce executes only once', () async {
    final debouncer = SafeDebouncer(delay: Duration(milliseconds: 100));
    int count = 0;

    debouncer.run(() => count++);
    debouncer.run(() => count++);
    debouncer.run(() => count++);

    await Future.delayed(Duration(milliseconds: 200));
    expect(count, 1);
  });

  test('cancel prevents execution', () async {
    final debouncer = SafeDebouncer(delay: Duration(milliseconds: 100));
    int count = 0;

    debouncer.run(() => count++);
    debouncer.cancel();

    await Future.delayed(Duration(milliseconds: 200));
    expect(count, 0);
  });

  test('keyed debouncer isolates calls', () async {
    final map = SafeDebouncerMap(delay: Duration(milliseconds: 100));
    int a = 0;
    int b = 0;

    map.run('a', () => a++);
    map.run('b', () => b++);

    await Future.delayed(Duration(milliseconds: 200));
    expect(a, 1);
    expect(b, 1);
  });
}
