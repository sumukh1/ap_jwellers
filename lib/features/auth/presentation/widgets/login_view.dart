import 'package:flutter/material.dart';
import 'package:myapp/core/widget/animations/staggered_animations.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/features/home/presentation/pages/home_page.dart'; // Import HomePage
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/AppImages.dart';
import 'package:myapp/static/AppNavigator.dart';
import 'package:myapp/static/constants.dart';

class LoginView extends StatelessWidget {
  final TextEditingController phoneController = TextEditingController();

  LoginView({super.key});

  // void _handleLogin(BuildContext context) {
  //   final phone = phoneController.text.trim();
  //   if (phone.isEmpty || phone.length < 10) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Please enter a valid phone number")),
  //     );
  //     return;
  //   }
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Logging in with +91 $phone")),
  //   );
  // }

  void _handleGoogleLogin(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Google login pressed")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppImages.curly,
          fit: BoxFit.cover,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            child: AnimatedColumn(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title or Logo
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      Styles.gap25,
                      // Phone input
                      PhoneField(
                        controller: phoneController,
                        label: '',
                        state: '',
                        placeHolder: 'Enter Phone Number',
                        enable: true,
                        showContactPicker: false,
                        onChange: (value) {},
                      ),
                      Styles.gap12,
                      // Login button
                      Button(
                        height: 50,
                        margin: Styles.edgeAll10,
                        onTap: () {
                          AppNavigator.pushReplacement(context, HomePage.route()); // Navigate to HomePage
                        },
                        label: "Login",
                        borderColor: null,
                      ),
                      Styles.gap12,

                      // OR divider
                      Row(
                        children: const [
                          Expanded(child: Divider(color: Colors.grey)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("or",
                                style: TextStyle(color: Colors.black54)),
                          ),
                          Expanded(child: Divider(color: Colors.grey)),
                        ],
                      ),
                      Styles.gap12,

                      // Google login
                      Button(
                        height: 50,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        onTap: () => _handleGoogleLogin(context),
                        label: "Continue with Google",
                        textColor: Constants.buttonText,
                        backgroundColor: Constants.WHITE,
                        borderColor: Colors.grey,
                      ),
                    ],
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
