import 'package:flutter/material.dart';

class ErrorDisplayWidget extends StatelessWidget {
  const ErrorDisplayWidget({
    super.key,
    required this.error,
    this.stackTrace,
  });

  final Object error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          size: 48,
        ),
        const SizedBox(height: 16),
        SelectableText.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Error: ',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: error.toString(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        if (stackTrace != null) ...[
          const SizedBox(height: 8),
          ExpansionTile(
            title: const Text('Detalles técnicos'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SelectableText(
                  stackTrace.toString(),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: 'monospace',
                      ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
