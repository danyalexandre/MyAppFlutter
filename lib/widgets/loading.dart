import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF666bd3),
      child: const SpinKitChasingDots(
        color: Colors.white,
        size: 100.0,
      ),
    );
  }
}
