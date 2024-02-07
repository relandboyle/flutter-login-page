import 'package:flutter/material.dart';

DateTime today = DateTime.now();
List<DateTime> options = <DateTime>[
  DateTime(today.year, today.month, today.day - 3),
  DateTime(today.year, today.month, today.day - 7),
  DateTime(today.year, today.month, today.day - 14),
  DateTime(today.year, today.month, today.day - 30),
  DateTime(today.year, today.month, today.day - 90),
];
// List<String> options = ['Last 3 Days', 'Last 7 Days', 'Last 14 Days', 'Last 30 Days', 'Last 90 Days'];

class DatePicker extends StatefulWidget {
  const DatePicker({super.key});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime dropdownValue = today;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownMenu<DateTime>(
        initialSelection: today,

        onSelected: (DateTime? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        dropdownMenuEntries: options.map<DropdownMenuEntry<DateTime>>((DateTime value) {
            return DropdownMenuEntry<DateTime>(value: value, label: value.toString());
        }).toList(),
      ),
    );
  }
}
