import 'package:flutter/material.dart';
import 'package:myapp/core/widget/lenear_progress_widget.dart'; // adjust path
import 'package:myapp/static/AppColors.dart';
import 'package:myapp/static/AppImages.dart';

class StudentProgressCard extends StatelessWidget {
  final int feesValue;
  final int feesTotal;
  final int attendanceValue;
  final int attendanceTotal;

  const StudentProgressCard({
    super.key,
    required this.feesValue,
    required this.feesTotal,
    required this.attendanceValue,
    required this.attendanceTotal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Column(
        children: [
          _progressRow("Fees", feesValue, feesTotal, isBold: true),
          SizedBox(height: 16),
          _progressRow("Attendance", attendanceValue, attendanceTotal,
              isBold: true),
        ],
      ),
    );
  }

  Widget _progressRow(String label, int value, int total,
      {bool isBold = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left column with label and progress
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                  fontSize: 16,
                  color: AppColors.textColor,
                ),
              ),
              SizedBox(height: 6),
              LenearProgressWidget(value: value, total: total),
            ],
          ),
        ),

        // Right arrow
        GestureDetector(
          onTap: () => {},
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.buttonText,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                AppImages.forword_arrow,
                width: 16,
                height: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
