import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

Logger logger = Logger();

// ignore: must_be_immutable
class DatePicker extends StatefulWidget {
  DatePicker({super.key, required this.startDate, required this.endDate, required this.dateGetter});

  @override
  State<DatePicker> createState() => _DatePickerState();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  Function(DateTime, DateTime) dateGetter;
}

class _DatePickerState extends State<DatePicker> {
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
                  padding: const EdgeInsets.all(50),
                  child: SfDateRangePicker(
                    onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                      logger.i(args.value.toString());
                      logger.i(args.value is PickerDateRange);
                      if (args.value is PickerDateRange) {
                        setState(() {
                          widget.startDate = DateTime.utc(args.value.startDate.year, args.value.startDate.month, args.value.startDate.day);
                          // widget.endDate = DateTime.utc(args.value.endDate.year, args.value.endDate.month, args.value.endDate.day);
                        });
                      } else {
                        setState(() {
                          // widget.startDate = DateTime.utc(args.value.startDate.year, args.value.startDate.month, args.value.startDate.day);
                          widget.endDate = DateTime.utc(args.value.endDate.year, args.value.endDate.month, args.value.endDate.day, 23, 59, 59);
                        });
                      }
                      widget.endDate = DateTime.utc(args.value.endDate.year, args.value.endDate.month, args.value.endDate.day, 23, 59, 59);
                      widget.dateGetter(widget.startDate, widget.endDate);
                    },
                    selectionMode: DateRangePickerSelectionMode.range,
                    initialSelectedRange: PickerDateRange(widget.startDate, widget.endDate),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
      child: const Text('Select'),
    );
  }
}
