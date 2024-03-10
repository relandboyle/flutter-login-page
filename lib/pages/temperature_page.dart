import 'package:flutter/material.dart';
import 'package:heat_sync/components/building_autocomplete.dart';
import 'package:heat_sync/components/unit_autocomplete.dart';
import 'package:heat_sync/components/date_picker.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';
import '../components/temperature_graph.dart';
import '../services/sensor_service.dart';
import '../models/building_data.dart';
import '../models/unit_data.dart';

final logger = Logger();

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  var selectedBuilding = BuildingData(fullAddress: '');
  var selectedUnit = UnitData(fullUnit: '');
  SensorService sensorService = SensorService();
  List<int> bottomTitleSpacer = [];
  List<FlSpot> insideSpots = [const FlSpot(0.0, 0.0)];
  List<FlSpot> outsideSpots = [const FlSpot(0.0, 0.0)];
  double bottomTitleInterval = 1.0;
  DateTime startDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);
  DateTime endDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);

  void selectBuilding(BuildingData building) {
    setState(() => selectedBuilding = building);
  }

  void selectUnit(UnitData unit) {
    setState(() => selectedUnit = unit);
  }

  void getStartDate(DateTime date) {
    setState(() => startDate = date);
  }

  void getEndDate(DateTime date) {
    setState(() => endDate = DateTime(date.year, date.month, date.day, 23, 59, 59));
  }

  void getDateRange(DateTime start, DateTime end) {
    setState(() {
      startDate = DateTime.utc(start.year, start.month, start.day, 0, 0, 0);
      endDate = DateTime.utc(end.year, end.month, end.day, 23, 59, 59);
    });
  }

  void getTemperatureData() async {
    Map<String, dynamic> data = {};
    data = await sensorService.getTemperatureData(selectedUnit.channelId, startDate, endDate);

    setState(() {
      insideSpots = data['spots'];
      outsideSpots = data['outsideSpots'];
      bottomTitleSpacer = data['bottomTitleSpacer'];
      bottomTitleInterval = (data['bottomTitleSpacer'][1] - data['bottomTitleSpacer'][0]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 850,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    color: Theme.of(context).colorScheme.primary,
                    elevation: 10,
                    child: TemperatureGraph(
                      insideSpots: insideSpots,
                      outsideSpots: outsideSpots,
                      bottomTitleSpacer: bottomTitleSpacer,
                      bottomTitleInterval: bottomTitleInterval,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: 350,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Date Range: ${DateFormat('MM/dd/yyyy').format(startDate)} - ${DateFormat('MM/dd/yyyy').format(endDate)}'),
                            const SizedBox(width: 10),
                            DatePicker(startDate: startDate, endDate: endDate, dateGetter: getDateRange),
                          ],
                        ),
                        const SizedBox(height: 40),
                        BuildingAutocomplete(
                          selectBuilding: selectBuilding,
                        ),
                        const SizedBox(height: 25),
                        UnitAutocomplete(
                          selectUnit: selectUnit,
                          selectedBuildingId: selectedBuilding.id,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: selectedUnit.channelId.isNotEmpty ? getTemperatureData : null,
                          style: selectedUnit.channelId.isNotEmpty
                              ? ButtonStyle(
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
                                )
                              : ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                  foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inversePrimary),
                                  padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(15),
                                  ),
                                ),
                          child: const Text('Get Temperature Data'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
