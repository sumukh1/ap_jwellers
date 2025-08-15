import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';

class AppDialog extends StatelessWidget {
  const AppDialog(
      {super.key,
      this.isWaring = false,
      this.isActionShow = true,
      this.title,
      this.message = '',
      this.onYes,
      this.onNo,
      this.child});
  final bool isWaring;
  final bool isActionShow;
  final String? title;
  final Widget? child;
  final String message;
  final VoidCallback? onYes;
  final VoidCallback? onNo;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fix height issue
          children: [
            if (title != null)
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.primary,
                      ),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (isWaring)
              Column(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: Colors.red, size: 50),
                  Text(
                    "WARNING",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),

            const SizedBox(height: 10),
            if (child != null) child!,
            // Description
            if (child == null)
              Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 20),

            // Action Buttons
            if (isActionShow)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                      if (onYes != null) {
                        onYes!();
                      }
                    },
                    child: Text("Yes",
                        style: TextStyle(
                          color: AppColors.white,
                        )),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                      if (onNo != null) {
                        onNo!();
                      }
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
