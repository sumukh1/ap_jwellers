import 'package:flutter/material.dart';
import 'package:myapp/core/widget/animations/staggered_animations.dart';
import 'package:myapp/core/widget/form.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/app_text.dart';
import 'package:myapp/static/constants.dart';

class DomainView extends StatelessWidget {
  const DomainView({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return AnimatedListView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      children: [
        Text(
          AppText.domainText,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.buttonText,
          ),
        ),
        Styles.gap32,
        const DomainSelectionButtons(),
        Styles.gap20,
        Button(
          label: "Continue",
          onTap: () {
            onNext();
          },
        ),
      ],
    );
  }
}

class DomainSelectionButtons extends StatefulWidget {
  const DomainSelectionButtons({
    super.key,
  });

  @override
  State<DomainSelectionButtons> createState() => _DomainSelectionButtonsState();
}

class _DomainSelectionButtonsState extends State<DomainSelectionButtons> {
  String selected = 'School';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: ['School', 'Institute'].map((type) {
        final isSelected = selected == type;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: OutlinedButton(
              onPressed: () {
                setState(() => selected = type);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isSelected ? AppColors.buttonText : Constants.grey,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: isSelected ? AppColors.buttonBackground.withOpacity(0.2) : AppColors.white,
              padding: const EdgeInsets.symmetric(vertical: 20),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.buttonText : Constants.grey,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
