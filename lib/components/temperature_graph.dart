import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

final logger = Logger();

// ignore: must_be_immutable
class TemperatureGraph extends StatefulWidget {
  TemperatureGraph({super.key, required this.spots, required this.outsideSpots, required this.bottomTitleSpacer});

  List<FlSpot> spots = [const FlSpot(0.0, 0.0)];
  List<FlSpot> outsideSpots = [const FlSpot(0.0, 0.0)];
  List<int> bottomTitleSpacer = [];

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

  String getFormattedDate(int dateMillis) {
    String formattedDate = DateFormat('EEE, MMM d').format(DateTime.fromMillisecondsSinceEpoch(dateMillis));
    logger.i('FORMATTED DATE: $formattedDate');
    return formattedDate;
  }

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
    String date = getFormattedDate(value.toInt());
    // logger.i('DATE: $date');
    Widget text;

    // if (widget.bottomTitleSpacer.contains(value.toInt())) {
    //   logger.i('VALUE: $value');
      text = Text(date, style: style);
    // } else {
    //   text = const Text('', style: style);
    // }

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
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
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Theme.of(context).colorScheme.primary,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            // map is returning x and y for both touchedBarSpots
            // consider a loop and return x/y for one, y-only for the other
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              if (flSpot.x == 0 || flSpot.x == 11) {
                return null;
              }
              return LineTooltipItem(
                '${flSpot.y}°F\n${flSpot.x}',
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            }).toList();
          },
        ),
        // touchCallback: (LineTouchResponse touchResponse) {},
        handleBuiltInTouches: true,
      ),
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
          spots: widget.spots.isNotEmpty ? widget.spots : [const FlSpot(0.0, 0.0)],
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
          spots: widget.outsideSpots.isNotEmpty ? widget.outsideSpots : [const FlSpot(0.0, 0.0)],
          isCurved: false,
          gradient: LinearGradient(
            colors: outsideGradient,
          ),
          barWidth: 3,
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
