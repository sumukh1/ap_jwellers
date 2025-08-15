import 'package:flutter/material.dart';
import 'package:myapp/core/widget/animations/staggered_animations.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/app_text.dart';

class SignupForm extends StatelessWidget {
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  SignupForm({super.key, required this.onNext});
  final VoidCallback onNext;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: Styles.edgeAll16,
      child: AnimatedColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.signupText,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.buttonText,
            ),
          ),
          const SizedBox(height: 32),

          // Form Fields
          AppTextField(
            label: "School/Institute Name",
            placeHolder: "Enter School/Institute Name",
            controller: schoolController,
          ),
          AppTextField(
            label: "Email Address",
            placeHolder: "Enter Your Email",
            controller: emailController,
          ),
          AppTextField(
            label: "Phone Number",
            placeHolder: "Enter Your Phone Number",
            controller: phoneController,
            isNumeric: true,
          ),
          AppTextField(
            label: "Operational Since",
            placeHolder: "DD/MM/YYYY",
            controller: dateController,
            readOnly: true,
            suffixIcon: const Icon(Icons.calendar_today, color: AppColors.grey),
            onTap: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                dateController.text =
                    "${picked.day}/${picked.month}/${picked.year}";
              }
            },
          ),
          AppTextField(
            label: "Address",
            placeHolder: "Enter Your Address",
            controller: addressController,
            suffixIcon:
                const Icon(Icons.location_on_outlined, color: Colors.grey),
          ),

          const SizedBox(height: 30),

          // Submit Button
          Button(
            label: "Continue",
            onTap: () {
              onNext();
            },
          ),
        ],
      ),
    );
  }
}
