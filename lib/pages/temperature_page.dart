import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login_page/components/building_autocomplete.dart';
import 'package:login_page/components/datetime_picker.dart';
import 'package:login_page/components/unit_autocomplete.dart';
import '../components/temperature_graph.dart';
import '../models/building_data.dart';
import '../models/temperature_entry.dart';
import '../models/unit_data.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

final logger = Logger();

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  var selectedBuilding = BuildingData(fullAddress: '');
  var selectedUnit = UnitData(fullUnit: '');
  Iterable<TemperatureEntry> temperatureEntries = <TemperatureEntry>[];
  List<FlSpot> spots = [const FlSpot(0, 20)];
  List<FlSpot> outsideSpots = [const FlSpot(0, 20)];
  bool swapSpots = false;
  DateTime startDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day - 7);
  DateTime endDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 59, 59);

  void selectBuilding(BuildingData building) {
    setState(() => selectedBuilding = building);
    logger.i('SELECTED BUILDING: ${selectedBuilding.fullAddress}');
  }

  void selectUnit(UnitData unit) {
    setState(() => selectedUnit = unit);
    logger.i('SELECTED UNIT: ${selectedUnit.fullUnit}');
  }

  void getStartDate(DateTime date) {
    setState(() => startDate = date);
    logger.i('START DATE: $startDate');
  }

  void getEndDate(DateTime date) {
    setState(() => endDate = DateTime(date.year, date.month, date.day, 23, 59, 59));
    logger.i('END DATE: $endDate');
  }

  // TODO: move this to sensor_service.dart
  void getTemperatureData() async {
    // request sensor data from the server passing channelId, startTime, and endTime
    await getSensorData(selectedUnit.channelId, startDate.toIso8601String(), endDate.toIso8601String());
    spots = temperatureEntries
        .map((entry) => FlSpot(
              DateTime.parse(entry.serverTime).millisecondsSinceEpoch.toDouble() / 10000000000,
              double.parse((double.parse(entry.temperature) * (9 / 5) + 32).toStringAsFixed(2)),
            ))
        .toList();
    outsideSpots = temperatureEntries
        .map((entry) => FlSpot(
              DateTime.parse(entry.serverTime).millisecondsSinceEpoch.toDouble() / 10000000000,
              double.parse((double.parse(entry.outsideTemperature) * (9 / 5) + 32).toStringAsFixed(2)),
            ))
        .toList();

    logger.i('SPOTS: $spots');
    logger.i('OUTSIDE SPOTS: $outsideSpots');

    setState(() {
      spots = spots;
      outsideSpots = outsideSpots;
      swapSpots = !swapSpots;
    });
  }

  // TODO: move this to sensor_service.dart
  Future<void> getSensorData(String? channelId, String dateRangeStart, String dateRangeEnd) async {
    logger.i('QUERY PARAMS: $channelId, $dateRangeStart, $dateRangeEnd');

    final response = await http
        .post(
            // Uri.parse("http://localhost:8089/api/v1/sensor/filteredSensorData"),
            Uri.parse('https://heat-sync-534f0413abe0.herokuapp.com/api/v1/sensor/filteredSensorData'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String?>{
              'channelId': channelId,
              'dateRangeStart': dateRangeStart,
              'dateRangeEnd': dateRangeEnd,
            }))
        .catchError((onError) {
      logger.e('Error fetching temperature data: $onError');
      return onError;
    });

    Iterable res = json.decode(response.body);
    logger.i('SENSOR DATA: $res');
    setState(() => temperatureEntries = res.map((entry) => TemperatureEntry.fromJson(entry)));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 800,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    elevation: 4,
                    child: TemperatureGraph(
                      spots: spots,
                      outsideSpots: outsideSpots,
                      swapSpots: swapSpots,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            DateTimePicker(
                              buttonText: 'Start Date',
                              currentDate: startDate,
                              updateDate: getStartDate,
                            ),
                            Text(
                              ' - ',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            DateTimePicker(
                              buttonText: 'End Date',
                              currentDate: endDate,
                              updateDate: getEndDate,
                            ),
                          ],
                        ),
                        const SizedBox(height: 25),
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
                                  elevation: MaterialStateProperty.all(10),
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primaryContainer),
                                  foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondaryContainer),
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
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inverseSurface),
                                  foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.inversePrimary),
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
