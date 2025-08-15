import 'package:flutter/material.dart';
import 'package:myapp/static/AppColors.dart';

class CustomCapsuleTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomCapsuleTabBar({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.brown.shade300, width: 1),
      ),
      // ✅ Important: Use Row here because Expanded only works in Row/Column/Flex
      child: Row(
        children: List.generate(tabs.length, (index) {
          final isActive = index == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: isActive ? Colors.white : AppColors.textColor,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
