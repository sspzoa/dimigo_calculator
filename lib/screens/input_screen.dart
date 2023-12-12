import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  const InputScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Input Screen'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/result'),
            child: const Text('점수 계산')),
      ),
    );
  }
}
