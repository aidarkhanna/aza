import 'package:flutter/material.dart';

class TwoWayCounter extends StatefulWidget {
  const TwoWayCounter({super.key});

  @override
  State<TwoWayCounter> createState() => _TwoWayCounterState();
}

class _TwoWayCounterState extends State<TwoWayCounter> {
  int _count = 0;
  bool _saving = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: _count > 0 ? () => setState(() => _count--) : null,
                  child: const Text('−'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text('$_count', style: const TextStyle(fontSize: 20)),
                ),
                FilledButton(
                  onPressed: () => setState(() => _count++),
                  child: const Text('+'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _saving
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.of(context);

                      setState(() => _saving = true);
                      await Future.delayed(const Duration(seconds: 2));

                      if (!mounted) return;

                      setState(() {
                        _saving = false;
                      });

                      messenger.showSnackBar(
                        const SnackBar(content: Text('Saved')),
                      );
                    },
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
