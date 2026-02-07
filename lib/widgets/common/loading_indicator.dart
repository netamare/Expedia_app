import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  LoadingIndicator({this.size = 36});
  @override
  Widget build(BuildContext context) {
    return Center(child: SizedBox(height: size, width: size, child: CircularProgressIndicator()));
  }
}