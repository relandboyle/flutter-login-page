import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Logger logger = Logger();

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  DatePicker({super.key, required this.startDate, required this.endDate, required this.dateGetter});

  @override
  State<DatePicker> createState() => _DatePickerState();

  DateTime startDate;
  DateTime endDate;
  DateTime todayMinus7 = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);
  DateTime today = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);
  Function(DateTime, DateTime) dateGetter;
}

class _DatePickerState extends State<DatePicker> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value.startDate != null && args.value.endDate != null) {
      widget.dateGetter(args.value.startDate, args.value.endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
        ),
        elevation: MaterialStateProperty.all(5),
        foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondaryContainer),
        backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
        padding: MaterialStateProperty.all(
          const EdgeInsets.all(15),
        ),
      ),
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 350,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                  child: SfDateRangePicker(
                    showNavigationArrow: true,
                    minDate: DateTime.utc(2021, 1, 1),
                    maxDate: DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59),
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(widget.startDate, widget.endDate),
                    onSelectionChanged: _onSelectionChanged,
                  ),
                ),
              ),
              // const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          side: BorderSide.none),
                    ),
                    foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
      child: const Text('Select'),
    );
  }
}
