import 'package:flutter/material.dart';
import 'package:mvvm/res/Colors/color.dart';

class RoundButton extends StatelessWidget {
  final String tital;
  final bool loading;
  final VoidCallback onPress;
  const RoundButton(
      {super.key,
      required this.tital,
      this.loading = false,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.buttonColor),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(color: Colors.white)
                : Text(
                    tital,
                    style: const TextStyle(color: AppColors.whiteColor),
                  )),
      ),
    );
  }
}
