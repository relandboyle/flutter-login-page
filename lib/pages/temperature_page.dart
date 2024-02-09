import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login_page/components/building_autocomplete.dart';
import 'package:login_page/components/unit_autocomplete.dart';
import '../components/date_picker.dart';
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
  late List<FlSpot> spots = <FlSpot>[const FlSpot(170.70894, 20), const FlSpot(170.71758, 20)];
  late List<FlSpot> outsideSpots = [const FlSpot(0, 0)];
  bool swapSpots = false;

  void selectBuilding(BuildingData building) {
    setState(() => selectedBuilding = building);
    logger.i('SELECTED BUILDING: ${selectedBuilding.fullAddress}');
  }

  void selectUnit(UnitData unit) {
    setState(() => selectedUnit = unit);
    logger.i('SELECTED UNIT: ${selectedUnit.fullUnit}');
  }

  // TODO: move this to sensor_service.dart
  void getTemperatureData() async {
    // request sensor data from the server passing channelId, startTime, and endTime
    await getSensorData('73844', '2024-01-15T00:00:00Z', '2024-02-05T23:59:59Z');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please select a date range:"),
                  SizedBox(width: 30),
                  DatePicker(),
                ],
              ),
              TemperatureGraph(
                spots: spots,
                outsideSpots: outsideSpots,
                swapSpots: swapSpots,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                        onPressed: !selectedUnit.channelId.isNotEmpty ? getTemperatureData : null,
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
            ],
          ),
        ),
      ),
    );
  }
}
