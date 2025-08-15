import 'package:myapp/core/widget/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:myapp/static/AppColors.dart';
import '../../static/constants.dart';

InputDecoration inputDecoration({
  required String placeHolder,
  String? errorText,
  EdgeInsets? padding,
}) {
  return InputDecoration(
    contentPadding: padding ?? Styles.edgeAll14,
    isDense: true,
    filled: true,
    fillColor: AppColors.white,
    hintText: placeHolder,
    hintStyle: const TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.normal,
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: Styles.borderRadius50,
        borderSide: BorderSide(width: 1, color: AppColors.black)),
    border: OutlineInputBorder(
        borderRadius: Styles.borderRadius50,
        borderSide: BorderSide(width: 1, color: AppColors.grey)),
  );
}

TextStyle inputTextStyle() {
  return TextStyle(
    fontSize: 14,
    color: Constants.BLACK, // Assuming AppConstants.BLACK
  );
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.state = "",
    this.label,
    this.placeHolder,
    this.isNumeric = false,
    this.validator,
    this.onChanged,
    this.autofocus = false,
    this.enable = true,
    this.errorText,
    this.maxLines,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
  });

  final TextEditingController? controller;
  final String? label;
  final String state;
  final String? placeHolder;
  final String? errorText;
  final bool isNumeric;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final int? maxLines;
  final bool autofocus;
  final bool enable;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      if (controller!.text != state) {
        final previousSelection = controller!.selection;
        controller!.text = state;
        final newOffset = previousSelection.baseOffset.clamp(
          0,
          controller!.text.length,
        );
        controller!.selection = TextSelection.fromPosition(
          TextPosition(offset: newOffset),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textColor, // Brown color
            ),
          ),
        const SizedBox(height: 8),
        TextFormField(
          readOnly: readOnly || !enable,
          autofocus: autofocus,
          controller: controller,
          maxLines: maxLines ?? 1,
          onTap: onTap,
          keyboardType: (maxLines ?? 1) > 1
              ? TextInputType.multiline
              : (isNumeric ? TextInputType.number : TextInputType.text),
          style: const TextStyle(fontSize: 15, color: Colors.black87),
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            hintText: placeHolder ?? label ?? '',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 20,
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: AppColors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                  color: AppColors.buttonBackground, width: 1.5),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child:
                Text('$errorText', style: const TextStyle(color: Colors.red)),
          )
        else
          const SizedBox(height: 14),
      ],
    );
  }
}

Widget labelTitle(String label) {
  return Text(
    label.toUpperCase(),
    style: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: Constants.PURPLE, // Assuming AppConstants.BLACK
    ),
  );
}

class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String state;
  final String placeHolder;
  final bool enable;
  final bool showContactPicker;
  final void Function(PhoneNumber)? onChange;
  final void Function(Country)? onCountryChange;
  const PhoneField({
    Key? key,
    required this.controller,
    required this.label,
    required this.state,
    required this.placeHolder,
    this.enable = true,
    this.showContactPicker = true,
    this.onChange,
    this.onCountryChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // void _showContactPicker() {
    //   showModalBottomSheet(
    //       context: context,
    //       isScrollControlled: true,
    //       builder: (context) {
    //         return StatefulBuilder(
    //           builder: (context, setModalState) {
    //             return ContactBottomModal(
    //               onTap: (phone) {
    //                 controller.text = phone.replaceAll(RegExp(r'\D'), '');
    //                 if (onChange != null)
    //                   onChange!(PhoneNumber(
    //                     number: phone,
    //                     countryCode: '+91',
    //                     countryISOCode: 'IN',
    //                   ));
    //                 Navigator.pop(context);
    //               },
    //             );
    //           },
    //         );
    //       });
    // }

    if (controller.text != state) {
      final previousSelection = controller.selection;
      controller.text = state;
      final newOffset = previousSelection.baseOffset.clamp(
        0,
        controller.text.length,
      );
      controller.selection = TextSelection.fromPosition(
        TextPosition(offset: newOffset),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelTitle(label), // assuming this is a custom widget you’ve created
        const SizedBox(height: 8),
        IntlPhoneField(
          readOnly: !enable,
          controller: controller,
          style: inputTextStyle(), // assuming this is a custom method
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: inputDecoration(placeHolder: placeHolder).copyWith(
              // suffixIcon:
              //     Constants.HAS_CONTACT_PERMISSION && enable && showContactPicker
              //         ? IconButton(
              //             icon: Icon(Icons.contacts),
              //             color: Constants.PURPLE,
              //             onPressed: _showContactPicker,
              //           )
              //         : null,
              ),
          dropdownTextStyle: inputTextStyle(),
          showDropdownIcon: false,
          showCountryFlag: false,
          initialCountryCode: 'IN',
          onChanged: onChange,
          onCountryChanged: onCountryChange,
          // disableLengthCheck: true,
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

// class ContactBottomModal extends StatefulWidget {
//   const ContactBottomModal({super.key, required this.onTap});
//   final Function(String) onTap;
//   @override
//   State<ContactBottomModal> createState() => _ContactBottomModalState();
// }

// class _ContactBottomModalState extends State<ContactBottomModal> {
//   List<Contact> filteredContacts = List.from(Constants.CONTACTS);
//   void updateSearch(String value) {
//     setState(() {
//       filteredContacts = Constants.CONTACTS.where((contact) {
//         final name = contact.displayName?.toLowerCase() ?? '';
//         final phone = contact.phones?.firstOrNull?.value ?? '';
//         return name.contains(value.toLowerCase()) || phone.contains(value);
//       }).toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final viewInsets = MediaQuery.of(context).viewInsets.bottom;
//     final availableHeight =
//         MediaQuery.of(context).size.height * 0.4 + viewInsets;

//     return ConstrainedBox(
//       constraints: BoxConstraints(
//         maxHeight: availableHeight,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: TextField(
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Icons.search),
//                 hintText: 'Search contacts',
//                 border: OutlineInputBorder(),
//               ),
//               onChanged: updateSearch,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Expanded(
//             child: filteredContacts.isEmpty
//                 ? const Center(child: Text('No contacts found.'))
//                 : ListView.builder(
//                     itemCount: filteredContacts.length,
//                     itemBuilder: (context, index) {
//                       final contact = filteredContacts[index];
//                       LogUtility.warning(contact.phones.toString());
//                       final phone = contact.phones?.firstOrNull?.value ?? '';
//                       return ListTile(
//                         title: Text(contact.displayName ?? ''),
//                         subtitle: Text(phone),
//                         onTap: () {
//                           if (phone.length > 10) {
//                             widget.onTap(phone.replaceFirst('91', ''));
//                             return;
//                           }
//                           widget.onTap(phone);
//                         },
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String state;
  final String placeHolder;
  final bool isNumeric;
  final Widget? prefix;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool enable;
  const PasswordField({
    super.key,
    this.enable = true,
    this.state = "",
    required this.controller,
    required this.label,
    required this.placeHolder,
    this.isNumeric = false,
    this.prefix,
    this.onChanged,
    this.validator,
  });

  @override
  State<StatefulWidget> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    if (widget.controller.text != widget.state) {
      final previousSelection = widget.controller.selection;
      widget.controller.text = widget.state;
      final newOffset = previousSelection.baseOffset.clamp(
        0,
        widget.controller.text.length,
      );
      widget.controller.selection = TextSelection.fromPosition(
        TextPosition(offset: newOffset),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelTitle(widget.label),
        const SizedBox(height: 8),
        TextFormField(
          controller: widget.controller,
          readOnly: !widget.enable,
          obscureText: _isObscured,
          textAlignVertical: TextAlignVertical.center,
          maxLines: 1,
          keyboardType:
              widget.isNumeric ? TextInputType.number : TextInputType.text,
          style: inputTextStyle(),
          decoration: inputDecoration(placeHolder: widget.placeHolder).copyWith(
            prefixIcon: widget.prefix,
            suffixIcon: IconButton(
              icon: Icon(
                _isObscured ? Icons.visibility_off : Icons.visibility,
                color: Constants.BLACK,
              ),
              onPressed: () {
                setState(() {
                  _isObscured = !_isObscured;
                });
              },
            ),
          ),
          onChanged: widget.onChanged,
          validator: widget.validator,
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class DatePickField extends StatelessWidget {
  final DateTime? selectedDate;
  final String label;
  final void Function(DateTime?) onChange;
  final String placeHolder;
  final bool enable;
  const DatePickField({
    super.key,
    this.selectedDate,
    required this.label,
    required this.onChange,
    required this.placeHolder,
    this.enable = true,
  });

  Future<void> _selectDate(BuildContext context) async {
    if (!enable) return;
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      onChange(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDate =
        selectedDate != null ? Constants.formatedDate(date: selectedDate!) : '';

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelTitle(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: TextEditingController(text: formattedDate),
          style: const TextStyle(fontSize: 12),
          decoration: inputDecoration(placeHolder: placeHolder),
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class TimePickField extends StatelessWidget {
  final DateTime selectedTime;
  final String label;
  final void Function(DateTime) onChange;
  final String placeHolder;
  final bool enable;

  const TimePickField({
    super.key,
    required this.selectedTime,
    required this.label,
    required this.onChange,
    required this.placeHolder,
    this.enable = true,
  });

  Future<void> _selectTime(BuildContext context) async {
    if (!enable) return;

    final TimeOfDay initialTime =
        TimeOfDay(hour: selectedTime.hour, minute: selectedTime.minute);

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );

    if (pickedTime != null) {
      final now = DateTime.now();
      final dt = DateTime(
          now.year, now.month, now.day, pickedTime.hour, pickedTime.minute);
      onChange(dt);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedTime = Constants.formatedTime(date: selectedTime);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) labelTitle(label),
        if (label.isNotEmpty) const SizedBox(height: 8),
        TextFormField(
          controller: TextEditingController(text: formattedTime),
          style: const TextStyle(fontSize: 12),
          decoration: inputDecoration(placeHolder: placeHolder),
          readOnly: true,
          onTap: () => _selectTime(context),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class DateTimePickField extends StatelessWidget {
  final DateTime? selectedDate;
  final String label;
  final void Function(DateTime?) onChange;
  final String placeHolder;
  final bool enable;
  const DateTimePickField({
    super.key,
    this.selectedDate,
    required this.label,
    this.enable = true,
    required this.onChange,
    required this.placeHolder,
  });

  Future<void> _selectDateTime(BuildContext context) async {
    if (!enable) return;
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
      );

      if (pickedTime != null) {
        DateTime finalDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onChange(finalDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String formattedDateTime = selectedDate != null
        ? Constants.formatedDateTime(date: selectedDate!)
        : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelTitle(label),
        const SizedBox(height: 8),
        TextFormField(
          controller: TextEditingController(text: formattedDateTime),
          style: const TextStyle(fontSize: 12),
          decoration: inputDecoration(placeHolder: placeHolder),
          readOnly: true,
          onTap: () => _selectDateTime(context),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class TransButton extends StatelessWidget {
  const TransButton({
    super.key,
    required this.label,
    this.onTap,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.textColor,
    this.backgroundColor,
    this.child,
    this.borderColor,
  });
  // final Color? color;
  final String label;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? child;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: padding ?? Styles.edgeAll10,
        margin: margin,
        child: Center(
          child: child ??
              Text(
                label,
                style: TextStyle(
                    color: textColor ?? AppColors.buttonText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          borderRadius: Styles.borderRadius50,
          border: Border.all(
            color: borderColor ?? AppColors.grey,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.label,
    this.onTap,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.textColor,
    this.backgroundColor,
    this.child,
    this.borderColor,
  });
  // final Color? color;
  final String label;
  final void Function()? onTap;
  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? textColor;
  final Color? backgroundColor;
  final Widget? child;
  final Color? borderColor;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        padding: padding ?? Styles.edgeAll10,
        margin: margin,
        child: Center(
          child: child ??
              Text(
                label,
                style: TextStyle(
                    color: textColor ?? AppColors.buttonText,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.buttonBackground,
          borderRadius: Styles.borderRadius50,
        ),
      ),
    );
  }
}

class YearPick extends StatefulWidget {
  final DateTime? selectedYear;
  final String label;
  final void Function(DateTime?) onChange;
  final String placeHolder;
  final bool enable;
  const YearPick({
    super.key,
    this.selectedYear,
    required this.label,
    required this.onChange,
    required this.placeHolder,
    this.enable = true,
  });

  @override
  _YearPickState createState() => _YearPickState();
}

class _YearPickState extends State<YearPick> {
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.selectedYear != null) {
      _yearController.text = widget.selectedYear!.year.toString();
    }
  }

  Future<void> _selectYear(BuildContext context) async {
    if (!widget.enable) return;
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.selectedYear ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      initialDatePickerMode: DatePickerMode.year, // Open in year selection mode
    );

    if (pickedDate != null) {
      setState(() {
        _yearController.text = pickedDate.year.toString();
      });
      widget.onChange(DateTime(pickedDate.year));
    }
  }

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelTitle(widget.label),
        const SizedBox(height: 8),
        TextFormField(
          controller: _yearController,
          style: const TextStyle(fontSize: 12),
          decoration: InputDecoration(
            hintText: widget.placeHolder,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            filled: true,
            fillColor: Constants.WHITE,
          ),
          readOnly: true,
          onTap: () => _selectYear(context), // Open the year picker
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}

class CustomSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color color;
  final double width;
  final bool enable;

  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.color = Colors.blue,
    this.width = 50.0,
    this.enable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = width / 2;
    final double thumbSize = height - 4;

    return GestureDetector(
      onTap: () => enable ? onChanged(!value) : null,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(height / 2),
          color: value ? color : Colors.grey[400],
        ),
        child: AnimatedAlign(
          duration: Duration(milliseconds: 200),
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          curve: Curves.easeInOut,
          child: Container(
            margin: const EdgeInsets.all(2),
            width: thumbSize,
            height: thumbSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Constants.WHITE,
              boxShadow: [
                BoxShadow(
                  color: Constants.BLACK,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTable extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;

  const CustomTable({Key? key, required this.columns, required this.rows})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Ensures full width usage
      decoration: BoxDecoration(
        color: Constants.WHITE,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Constants.BLACK, blurRadius: 5, offset: Offset(0, 3)),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Table(
        border: TableBorder.all(color: Colors.grey, width: 1),
        columnWidths: {
          for (int i = 0; i < columns.length; i++) i: FlexColumnWidth(1),
        }, // Distributes space evenly
        children: [
          // Header Row
          TableRow(
            decoration: BoxDecoration(color: Colors.blue),
            children: columns
                .map(
                  (col) => Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      col,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Constants.WHITE,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
                .toList(),
          ),
          // Data Rows
          ...rows.map(
            (row) => TableRow(
              children: row
                  .map(
                    (cell) => Padding(
                      padding: EdgeInsets.all(12),
                      child: Text(
                        cell,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Constants.BLACK),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class OtpInput extends StatelessWidget {
  final int length;
  final List<TextEditingController> controllers;
  final Function(String) onCompleted;

  OtpInput({
    Key? key,
    this.length = 4,
    required this.controllers,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Container(
          width: 50,
          height: 50,
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: controllers[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Constants.WHITE, // Set text color to white
            ),
            cursorColor: Constants.WHITE, // Set cursor color to white
            decoration: InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Constants.WHITE), // White border
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.WHITE,
                ), // White border when not focused
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Constants.WHITE,
                  width: 2,
                ), // White border when focused
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < length - 1) {
                FocusScope.of(context).nextFocus();
              }
              _checkCompletion();
            },
            onTap: () => controllers[index].selection = TextSelection(
              baseOffset: 0,
              extentOffset: controllers[index].text.length,
            ),
            onSubmitted: (_) => _checkCompletion(),
          ),
        ),
      ),
    );
  }

  void _checkCompletion() {
    String otpCode = controllers.map((c) => c.text).join();
    if (otpCode.length == length) {
      onCompleted(otpCode);
    }
  }
}

class DateSelector extends StatelessWidget {
  final String label;
  final String? selectedYear;
  final String? selectedMonth;
  final String? selectedDay;
  final Function(String?) onYearChanged;
  final Function(String?) onMonthChanged;
  final Function(String?) onDayChanged;

  const DateSelector({
    super.key,
    required this.label,
    this.selectedYear,
    this.selectedMonth,
    this.selectedDay,
    required this.onYearChanged,
    required this.onMonthChanged,
    required this.onDayChanged,
  });

  List<String> getYears() {
    final now = DateTime.now();
    return List.generate(10, (index) => (now.year - 5 + index).toString());
  }

  List<String> getMonths() {
    return List.generate(12, (index) => (index + 1).toString().padLeft(2, '0'));
  }

  List<String> getDays() {
    return List.generate(31, (index) => (index + 1).toString().padLeft(2, '0'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              color: AppColors.textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            )),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                hint: 'YYYY',
                value: selectedYear,
                items: getYears(),
                onChanged: onYearChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDropdown(
                hint: 'MM',
                value: selectedMonth,
                items: getMonths(),
                onChanged: onMonthChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildDropdown(
                hint: 'DD',
                value: selectedDay,
                items: getDays(),
                onChanged: onDayChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Constants.WHITE,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black26),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        value: value,
        hint: Text(hint),
        onChanged: onChanged,
        items: items
            .map((e) => DropdownMenuItem<String>(
                  value: e,
                  child: Text(e),
                ))
            .toList(),
      ),
    );
  }
}
