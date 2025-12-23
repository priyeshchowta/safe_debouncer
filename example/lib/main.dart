import 'package:flutter/material.dart';
import 'package:safe_debouncer/safe_debouncer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final debouncer = SafeDebouncer(delay: Duration(milliseconds: 500));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Safe Debouncer Example')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            onChanged: (value) {
              debouncer.run(() {
                debugPrint('Search: $value');
              });
            },
            decoration: const InputDecoration(
              labelText: 'Type to debounce',
            ),
          ),
        ),
      ),
    );
  }
}
