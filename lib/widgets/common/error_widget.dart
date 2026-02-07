import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const CustomErrorWidget({required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(message, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
          SizedBox(height: 12),
          if (onRetry != null)
            ElevatedButton(onPressed: onRetry, child: Text('Retry'))
        ]),
      ),
    );
  }
}