import 'package:flutter/material.dart';
import 'package:safe_debouncer/safe_debouncer.dart';

void main() {
  runApp(const SafeDebouncerExampleApp());
}

class SafeDebouncerExampleApp extends StatelessWidget {
  const SafeDebouncerExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DebouncerDemoPage(),
    );
  }
}

class DebouncerDemoPage extends StatefulWidget {
  const DebouncerDemoPage({super.key});

  @override
  State<DebouncerDemoPage> createState() => _DebouncerDemoPageState();
}

class _DebouncerDemoPageState extends State<DebouncerDemoPage> {
  late final SafeDebouncer _debouncer;

  String _rawInput = '';
  String _debouncedValue = '';
  int _debounceCount = 0;

  @override
  void initState() {
    super.initState();
    _debouncer = SafeDebouncer(
      delay: const Duration(milliseconds: 600),
    );
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('safe_debouncer Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Type quickly below. Only the final value after a pause '
              'will be processed.',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),

            /// INPUT FIELD
            TextField(
              decoration: const InputDecoration(
                labelText: 'Type here',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _rawInput = value;
                });

                _debouncer.run(() async {
                  // Simulate async work (e.g., API call)
                  await Future.delayed(const Duration(milliseconds: 500));

                  if (!mounted) return;

                  setState(() {
                    _debouncedValue = value;
                    _debounceCount++;
                  });
                });
              },
            ),

            const SizedBox(height: 24),

            /// DISPLAY RESULTS
            Text(
              'Raw input:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              _rawInput,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 16),

            Text(
              'Debounced value (after delay):',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              _debouncedValue,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Debounce executions:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '$_debounceCount',
              style: const TextStyle(fontSize: 18),
            ),

            const Spacer(),

            const Text(
              'Try typing fast vs pausing to see the difference.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
