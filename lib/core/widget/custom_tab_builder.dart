import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/constants.dart';
import 'package:flutter/material.dart';

class CustomTabBuilder extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> pages;
  final ValueChanged<int> onTabChanged;
  const CustomTabBuilder({
    Key? key,
    required this.tabs,
    required this.pages,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  State<CustomTabBuilder> createState() => _CustomTabBuilderState();
}

class _CustomTabBuilderState extends State<CustomTabBuilder> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  void _onTabTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
    widget.onTabChanged(index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Custom Tab Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.tabs.length, (index) {
            final bool isSelected = _selectedIndex == index;
            return Expanded(
              child: GestureDetector(
                  onTap: () => _onTabTap(index),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 350),
                    curve: Curves.easeInOut,
                    margin: Styles.edgeAll4,
                    padding: Styles.edgeV8,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? Constants.LIGHT_BLUE : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.tabs[index],
                      style: TextStyle(
                        color: isSelected ? Constants.WHITE : Constants.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )),
            );
          }),
        ),

        // Swipe-able Views
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: widget.pages,
          ),
        ),
      ],
    );
  }
}
