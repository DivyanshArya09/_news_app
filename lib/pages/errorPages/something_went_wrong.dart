import 'package:flutter/material.dart';

class SomeThingWentWrong extends StatelessWidget {
  const SomeThingWentWrong({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .7,
      width: size.width,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.error, size: 100, color: Colors.red),
          SizedBox(
            height: 40,
          ),
          Text(
            'no results found',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
