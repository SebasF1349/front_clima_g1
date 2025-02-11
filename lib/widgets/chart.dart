import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:clima_app/themes/catppuccin_colors.dart';

class Chart extends StatelessWidget {
  final String type;
  final List<String> labels;
  final List<double> min;
  final List<double>? max;
  final bool? disableClick;

  const Chart(
      {required this.labels,
      required this.min,
      this.max,
      required this.type,
      this.disableClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, Color> colors = catppuccinColors();

    List<LineChartBarData> chartData = [];
    chartData.add(getSpots(min, colors['blue']!));
    if (max != null) chartData.add(getSpots(max!, colors['maroon']!));
    List<ShowingTooltipIndicators> tooltipIndicators =
        chartData[0].spots.asMap().entries.map((entry) {
      if (chartData.length == 1) {
        return ShowingTooltipIndicators(
            [LineBarSpot(chartData[0], 0, chartData[0].spots[entry.key])]);
      } else {
        return ShowingTooltipIndicators([
          LineBarSpot(chartData[1], 0, chartData[1].spots[entry.key]),
          LineBarSpot(chartData[0], 0, chartData[0].spots[entry.key]),
        ]);
      }
    }).toList();

    double maxX = labels.length - 0.5;
    double width = maxX * 80;
    double height = 100;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: LineChart(
                LineChartData(
                    showingTooltipIndicators: tooltipIndicators,
                    minX: -0.5,
                    maxX: maxX,
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: false,
                      verticalInterval: 1.0,
                      getDrawingVerticalLine: (value) {
                        return FlLine(
                          color: colors['surface1'],
                          strokeWidth: 1,
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              const style = TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              );
                              String label = value == value.roundToDouble()
                                  ? labels[value.toInt()]
                                  : '';
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 4,
                                child: Text(label, style: style),
                              );
                            },
                          ),
                        )),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    lineTouchData: LineTouchData(
                        handleBuiltInTouches: false,
                        touchSpotThreshold: 40,
                        touchCallback:
                            (FlTouchEvent event, LineTouchResponse? response) {
                          if (response == null ||
                              response.lineBarSpots == null ||
                              disableClick == true) {
                            return;
                          }
                          if (event is FlTapUpEvent) {
                            final spotIndex =
                                response.lineBarSpots!.first.spotIndex;
                            Navigator.pushNamed(
                                context,
                                type == 'diario'
                                    ? 'pronostico_unitario_dia'
                                    : 'pronostico_unitario_hora',
                                arguments: <String, dynamic>{
                                  'label': labels[spotIndex],
                                });
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        touchTooltipData: LineTouchTooltipData(
                            fitInsideVertically: true,
                            tooltipMargin: 5,
                            getTooltipColor: (touchedSpot) {
                              return colors['surface1']!;
                            },
                            getTooltipItems: (lineBarsSpot) {
                              return lineBarsSpot.indexed.map((spot) {
                                final (index, value) = spot;
                                Color color = (max == null)
                                    ? colors['blue']!
                                    : (index == 0)
                                        ? colors['maroon']!
                                        : colors['blue']!;
                                return LineTooltipItem(
                                  value.y.toStringAsFixed(0),
                                  TextStyle(
                                      color: color,
                                      fontWeight: FontWeight.bold),
                                );
                              }).toList();
                            },
                            tooltipPadding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3))),
                    lineBarsData: chartData),
              ),
            ),
          )),
    );
  }

  LineChartBarData getSpots(List<double> temp, Color color) {
    List<FlSpot> spots = temp
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();
    return LineChartBarData(
        spots: spots,
        preventCurveOverShooting: true,
        belowBarData: BarAreaData(show: false),
        color: color,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            const radius = 3.0;
            return FlDotCirclePainter(
              radius: radius,
              color: color,
              strokeColor: color,
              strokeWidth: radius / 2,
            );
          },
        ),
        isCurved: true);
  }
}

