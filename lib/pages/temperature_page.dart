import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:login_page/components/building_autocomplete.dart';
import 'package:login_page/components/unit_autocomplete.dart';
import '../components/temperature_graph.dart';
import '../models/building_data.dart';
import '../models/unit_data.dart';

final logger = Logger();

class TemperaturePage extends StatefulWidget {
  const TemperaturePage({super.key});

  @override
  State<TemperaturePage> createState() => _TemperaturePageState();
}

class _TemperaturePageState extends State<TemperaturePage> {
  final buildingController = TextEditingController();
  final unitController = TextEditingController();
  var selectedBuilding = BuildingData(fullAddress: '');
  var selectedUnit = UnitData(fullUnit: '');

  void selectBuilding(BuildingData building) {
    setState(() => selectedBuilding = building);
    logger.i('Temperature/selectBuilding(): ${selectedBuilding.fullAddress}');
  }

  void selectUnit(UnitData unit) {
    setState(() => selectedUnit = unit);
    logger.i('Temperature/selectUnit(): ${selectedUnit.fullUnit}');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TemperatureGraph(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildingAutocomplete(selectBuilding: selectBuilding),
                    const SizedBox(height: 25),
                    UnitAutocomplete(selectUnit: selectUnit),
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
