import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:logger/logger.dart';

Logger logger = Logger();

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key, required this.buttonText, required this.currentDate, required this.updateDate});

  final String buttonText;
  final DateTime currentDate;
  final Function(DateTime) updateDate;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        DatePicker.showDatePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2020, 1, 1),
          maxTime: DateTime.now(),
          onChanged: (date) {
            logger.i('change $date');
          },
          onConfirm: (date) {
            updateDate(date);
            logger.i('confirm $date');
          },
          currentTime: currentDate,
          locale: LocaleType.en,
        );
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        side: BorderSide(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          width: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        currentDate.toString().substring(0, 10),
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
          fontSize: 16,
        ),
      ),
    );
  }
}
