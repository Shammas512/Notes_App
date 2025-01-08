import 'package:flutter/material.dart';

class ContainerUser extends StatelessWidget {
  String text;
  ContainerUser({super.key,required this.text});

  @override
  Widget build(BuildContext context) {
    return (Container(
      height: 70,
      width: 230,
      decoration: BoxDecoration(
          color: Colors.deepPurple[100],
          borderRadius: BorderRadius.circular(13)),
      child: Center(
        child: TextField(
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
          ),
        ),
      ),
    ));
  }
}
