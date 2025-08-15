import 'package:flutter/material.dart';
import 'package:myapp/core/widget/animations/staggered_animations.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/AppNavigator.dart';
import 'package:myapp/static/app_text.dart';
import 'package:myapp/features/home/presentation/pages/home_page.dart';
import 'package:myapp/core/widget/file_picker.dart';

class LogoPageView extends StatefulWidget {
  const LogoPageView({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<LogoPageView> createState() => _LogoPageViewState();
}

class _LogoPageViewState extends State<LogoPageView> {
  String? _selectedLogoPath;

  void _handleLogoUpload(List<String> paths) {
    if (paths.isNotEmpty) {
      setState(() {
        _selectedLogoPath = paths.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      children: [
        Text(
          AppText.yourLogo,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonText,
          ),
        ),
        Styles.gap8,
        Text(
          AppText.connectText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 40),
        Center(
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey.withOpacity(0.2),
              border: Border.all(color: AppColors.grey, width: 1.5),
            ),
            child: _selectedLogoPath != null
                ? ClipOval(
                    child: UniversalImageView(
                      path: _selectedLogoPath!,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  )
                : Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.grey,
                    size: 50,
                  ),
          ),
        ),
        const SizedBox(height: 50),
        AppFilePicker(
          label: "Upload Logo",
          onChange: _handleLogoUpload,
        ),
        Styles.gap16,
        TransButton(
          label: "Skip",
          height: 50,
          backgroundColor: Colors.transparent,
          borderColor: AppColors.grey,
          textColor: AppColors.buttonText,
          onTap: () {
            AppNavigator.pushReplacement(context, HomePage.route());
          },
        ),
      ],
    );
  }
}
