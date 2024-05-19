import 'package:flutter/material.dart';
import 'package:home_work_second/UI/theme.dart';
class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;

  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryColor,

        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,

            ),
          ),
        ),
      )
    );
  }

}
