import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/AppColors.dart';

class CalendarDaySelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final DateTime? initialDate;

  const CalendarDaySelector({
    super.key,
    required this.onDateSelected,
    this.initialDate,
  });

  @override
  State<CalendarDaySelector> createState() => _CalendarDaySelectorState();
}

class _CalendarDaySelectorState extends State<CalendarDaySelector> {
  late DateTime selectedDate;
  late List<DateTime> monthDays;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate ?? DateTime.now();
    monthDays = _generateMonthDays(selectedDate);
  }

  List<DateTime> _generateMonthDays(DateTime date) {
    final lastDay = DateTime(date.year, date.month + 1, 0);
    return List.generate(
      lastDay.day,
      (index) => DateTime(date.year, date.month, index + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: Styles.edgeInsetsOnlyB04,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: monthDays.length,
        separatorBuilder: (_, __) => const SizedBox(width: 6),
        itemBuilder: (context, index) {
          final date = monthDays[index];
          final isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
              widget.onDateSelected(date);
            },
            child: Container(
              width: 48,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.buttonBackground : Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.buttonText, width: 1),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.textColor
                          : AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('E').format(date), // Mon, Tue
                    style: TextStyle(
                      fontSize: 8,
                      color: isSelected
                          ? AppColors.textColor
                          : AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
