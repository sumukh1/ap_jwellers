import 'package:flutter/material.dart';
import 'package:myapp/core/widget/styles.dart';
import 'package:myapp/static/AppColors.dart';

class CustomDropdown extends StatefulWidget {
  final void Function(String?)? onChanged;
  final List<String> list;
  final String label;
  final String? placeHolder;
  final String? selectedValue;
  final bool enable;
  final bool search;

  const CustomDropdown({
    Key? key,
    this.onChanged,
    required this.list,
    required this.label,
    this.placeHolder,
    this.selectedValue,
    this.enable = true,
    this.search = true,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late List<String> filteredItems;
  final TextEditingController _searchController = TextEditingController();
  String? _currentValue;
  bool _isDropdownOpened = false;

  @override
  void initState() {
    super.initState();
    filteredItems = widget.list;
    _currentValue = widget.selectedValue;
    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        filteredItems = widget.list
            .where((item) => item.toLowerCase().contains(query))
            .toList();
      });
    });
  }

  @override
  void didUpdateWidget(covariant CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != _currentValue) {
      _currentValue = widget.selectedValue;
    }
    if (widget.list != oldWidget.list) {
      filteredItems = widget.list;
    }
  }

  void _toggleDropdown() {
    if (!widget.enable) return;
    setState(() {
      _isDropdownOpened = !_isDropdownOpened;
      if (_isDropdownOpened) {
        _searchController.clear();
        filteredItems = widget.list;
      }
    });
  }

  void _selectItem(String? value) {
    setState(() {
      _currentValue = value;
      _isDropdownOpened = false;
      if (widget.onChanged != null) widget.onChanged!(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
                fontSize: 16)),
        const SizedBox(height: 6),
        GestureDetector(
          onTap: _toggleDropdown,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.grey.shade400,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    _currentValue ?? widget.placeHolder ?? widget.label,
                    style: TextStyle(
                      color: _currentValue == null
                          ? Colors.grey.shade600
                          : Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
        if (_isDropdownOpened) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                if (widget.search)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, size: 20),
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      ),
                    ),
                  ),
                const Divider(height: 1, color: Colors.grey),
                SizedBox(
                  height: 140,
                  child: filteredItems.isEmpty
                      ? const Center(child: Text('No items found'))
                      : ListView.builder(
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            final item = filteredItems[index];
                            final selected = item == _currentValue;
                            return ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              title: Text(item,
                                  style: const TextStyle(fontSize: 14)),
                              selected: selected,
                              onTap: () => _selectItem(item),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
        Styles.gap10,
      ],
    );
  }
}
