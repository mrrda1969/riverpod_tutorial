import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main.g.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

@riverpod
class Counter extends _$Counter {
  @override
  int build() => 0;

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => counter < 10
                      ? ref.read(counterProvider.notifier).increment()
                      : null,
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => counter > 0
                      ? ref.read(counterProvider.notifier).decrement()
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
