import 'package:flutter/material.dart';

class MovieLoading extends StatelessWidget {
  const MovieLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
