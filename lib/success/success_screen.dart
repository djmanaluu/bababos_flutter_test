import 'package:bababos_test/commons/ui/base_button.dart';
import 'package:bababos_test/commons/ui/base_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SuccessScreen extends StatelessWidget {
  static const routeName = "/success";

  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SvgPicture.asset(
              "assets/images/big_logo.svg",
              height: 50.0,
            ),
            const SizedBox(height: 40.0),
            const Text(
              "Thank you for use our service.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: BaseColors.darkGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            BaseButton(
              title: "Back to Home",
              onTapped: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
