import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login_page/components/building_autocomplete.dart';
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

  void selectBuilding(BuildingData building) {
    setState(() => selectedBuilding = building);
    logger.i('SELECTED BUILDING: ${selectedBuilding.fullAddress}');
  }

  void selectUnit(UnitData unit) {
    setState(() => selectedUnit = unit);
    logger.i('SELECTED UNIT: ${selectedUnit.fullUnit}');
  }

  void getTemperatureData() {
    getSensorData(selectedUnit.channelId, '2024-02-04T20:00:00Z', '2024-02-05T23:59:59Z');
  }

  Future<void> getSensorData(String? channelId, String dateRangeStart, String dateRangeEnd) async {
    final response = await http
        .post(Uri.parse("http://localhost:8089/api/v1/sensor/filteredSensorData"),
            // Uri.parse('https://heat-sync-534f0413abe0.herokuapp.com/api/v1/sensor/filteredSensorData'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String?, String?>{
              'channelId': channelId,
              'dateRangeStart': dateRangeStart,
              'dateRangeEnd': dateRangeEnd,
            }))
        .catchError((onError) {
      logger.e('Error fetching temperature data: $onError');
      return onError;
    });

    Iterable res = json.decode(response.body);
    logger.i('RESPONSE: $res');
    temperatureEntries = res.map((entry) => TemperatureEntry.fromJson(entry));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TemperatureGraph(
              temperatureEntries: temperatureEntries,
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
                        onPressed: selectedUnit.channelId.isNotEmpty ? getTemperatureData : null,
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 83, 215, 68)),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(const EdgeInsets.all(15)),
                        ),
                        child: const Text('Get Temperature Data')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
