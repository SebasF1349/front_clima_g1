import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  final List<String> labels;
  final List<double> min;
  final List<double>? max;

  const Chart({required this.labels, required this.min, this.max, super.key});

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> chartData = [];
    chartData.add(getSpots(min));
    if (max != null) chartData.add(getSpots(max!));
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
    // var {'min': globalMin, 'max': globalMax} = getMaxMin([min, max ?? []]);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
          height: height,
          width: width,
          // padding: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: LineChart(
                LineChartData(
                    // clipData: const FlClipData.all(),
                    showingTooltipIndicators: tooltipIndicators,
                    // minY: globalMin,
                    // maxY: globalMax + 10,
                    minX: -0.5,
                    maxX: maxX,
                    // gridData: const FlGridData(show: false),
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: false,
                      verticalInterval: 1.0,
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: Colors.grey,
                          strokeWidth: 1,
                        );
                      },
                    ),
                    // borderData: FlBorderData(show: false),
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
                              response.lineBarSpots == null) {
                            return;
                          }
                          if (event is FlTapUpEvent) {
                            final spotIndex =
                                response.lineBarSpots!.first.spotIndex;
                            // print('touched index: $spotIndex');
                            Navigator.pushNamed(context, 'pronostico_dia',
                                arguments: <String, dynamic>{
                                  'day': spotIndex,
                                });
                            FocusManager.instance.primaryFocus?.unfocus();
                          }
                        },
                        touchTooltipData: LineTouchTooltipData(
                            fitInsideVertically: true,
                            // showOnTopOfTheChartBoxArea: true,
                            tooltipMargin: 5,
                            getTooltipColor: (touchedSpot) {
                              // print(touchedSpot.spotIndex);
                              // print(touchedSpot);
                              return Colors.lightGreenAccent;
                              // return LinearGradient(
                              //   begin: Alignment.topRight,
                              //   end: Alignment.bottomLeft,
                              //   colors: [
                              //     Colors.blue,
                              //     Colors.red,
                              //   ],
                              // );
                            },
                            getTooltipItems: (lineBarsSpot) {
                              return lineBarsSpot.indexed.map((spot) {
                                final (index, value) = spot;
                                Color color =
                                    (index == 0) ? Colors.red : Colors.blue;
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
                    // titlesData: FlTitlesData(
                    //     bottomTitles: const AxisTitles(),
                    //     topTitles: AxisTitles(
                    //       sideTitles: SideTitles(
                    //         showTitles: true,
                    //         reservedSize: 30,
                    //         getTitlesWidget: (double value, TitleMeta meta) {
                    //           return SideTitleWidget(
                    //             axisSide: meta.axisSide,
                    //             space: 4,
                    //             child: const Text('l'),
                    //           );
                    //         },
                    //       ),
                    //     )),
                    lineBarsData: chartData),
              ),
            ),
          )),
    );
  }

  LineChartBarData getSpots(List<double> temp) {
    List<FlSpot> spots = temp
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();
    return LineChartBarData(
        spots: spots,
        preventCurveOverShooting: true,
        belowBarData: BarAreaData(show: false),
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) {
            const radius = 3.0;
            const color = Colors.blue;
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

  Map<String, double> getMaxMin(List<List<double>> temp) {
    var max = temp[0][0];
    var min = temp[0][0];

    for (var t in temp) {
      if (t.isNotEmpty) {
        t.sort();
        if (t.first < min) {
          min = t.first;
        }
        if (t.last < max) {
          max = t.last;
        }
      }
    }

    return {'min': min, 'max': max};
  }
}
