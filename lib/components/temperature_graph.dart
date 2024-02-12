import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

// ignore: must_be_immutable
class TemperatureGraph extends StatefulWidget {
  TemperatureGraph({super.key, required this.spots, required this.outsideSpots});

  List<FlSpot> spots;
  List<FlSpot> outsideSpots;

  @override
  State<TemperatureGraph> createState() => _TemperatureGraphState();
}

class _TemperatureGraphState extends State<TemperatureGraph> {
  List<Color> insideGradient = [
    Colors.green.shade300,
    Colors.blue.shade300,
  ];
  List<Color> outsideGradient = [
    Colors.deepOrange.shade700,
    Colors.deepPurple.shade700,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.only(
              right: 18,
              left: 12,
              top: 24,
              bottom: 12,
            ),
            child: LineChart(
              chartData(),
              duration: const Duration(milliseconds: 800),
              chartRendererKey: const Key('linechart'),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('JAN', style: style);
        break;
      case 2:
        text = const Text('MAR', style: style);
        break;
      case 5:
        text = const Text('JUN', style: style);
        break;
      case 8:
        text = const Text('SEP', style: style);
        break;
      case 11:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = value.toInt().toString();
        break;
      case 20:
        text = '20°F';
        break;
      case 40:
        text = '40°F';
        break;
      case 60:
        text = '60°F';
        break;
      case 80:
        text = '80°F';
        break;
      case 100:
        text = '100°F';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData chartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 5,
        verticalInterval: 0.0005,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Theme.of(context).colorScheme.secondary,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Theme.of(context).colorScheme.secondaryContainer,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 42,
            interval: 20,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      minX: widget.spots.first.x,
      maxX: widget.spots.last.x,
      minY: -10,
      maxY: 110,
      lineBarsData: [
        LineChartBarData(
          spots: widget.spots,
          isCurved: true,
          gradient: LinearGradient(
            colors: insideGradient,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: const Alignment(-1.0, 0.0),
              end: const Alignment(1.0, 0.0),
              colors: insideGradient.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
        LineChartBarData(
          // curveSmoothness: 1.5,
          spots: widget.outsideSpots,
          isCurved: true,
          gradient: LinearGradient(
            colors: outsideGradient,
          ),
          barWidth: 5,
          isStrokeCapRound: false,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              begin: const Alignment(-1.0, 0.0),
              end: const Alignment(1.0, 0.0),
              colors: outsideGradient.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
