import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:myapp/core/widget/animations/staggered_animations.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/features/auth/presentation/pages/signup_page.dart';
// import 'package:myapp/features/home/presentation/pages/homepage.dart';
import 'package:myapp/static/AppNavigator.dart';
import 'package:myapp/static/app_text.dart';
import 'package:myapp/static/AppColors.dart';

class VerifyView extends StatelessWidget {
  final TextEditingController otpController = TextEditingController();
  final bool isOtpIncorrect;
  final int secondsLeft;

  VerifyView({
    super.key,
    this.isOtpIncorrect = false,
    this.secondsLeft = 30,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppText.almostThereMagicCode,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonText,
          ),
        ),
        Styles.gap12,
        const Text(
          "Enter 4 digit otp sent on your phone number.",
          style: TextStyle(
            fontSize: 14,
            color: AppColors.textColor,
          ),
        ),
        Styles.gap32,

        // OTP Fields
        Pinput(
          controller: otpController,
          length: 4,
          keyboardType: TextInputType.number,
          onChanged: (String value) {},
          defaultPinTheme: PinTheme(
            height: 50,
            width: 50,
            textStyle: TextStyle(fontSize: 20, color: AppColors.textColor),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        if (isOtpIncorrect)
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "Incorrect OTP",
              style: TextStyle(color: Colors.red),
            ),
          ),
        Styles.gap32,
        // Verify Button
        Button(
          height: 50,
          label: "Verify",
          onTap: () {
            // AppNavigator.push(context, HomePage.route());
            AppNavigator.push(context, SignupPage.route());
          },
          backgroundColor: AppColors.buttonBackground,
          textColor: AppColors.buttonText,
          borderColor: null,
        ),
        Styles.gap16,
        Center(
          child: RichText(
            text: TextSpan(
              text: 'Resend ',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.buttonText,
              ),
              children: [
                TextSpan(
                  text: 'in $secondsLeft sec',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
