import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class Mybarriers extends StatelessWidget {
  final size;

  Mybarriers(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(
          width: 10,
          color: const Color.fromARGB(255, 12, 156, 17),
        ),
      ),
    );
  }
}
