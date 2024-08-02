import 'dart:math';

import 'package:auto_depura/ui/pages/grafico/line_titles.dart';
import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraficoPage extends StatefulWidget {
  final Map<String, dynamic> results;
  final List<Color> n0GradientColors = [
    const Color(0xff23b6e6).withOpacity(.6),
    const Color(0xff02d39a).withOpacity(.6),
  ];
  GraficoPage({super.key, required this.results});

  @override
  State<GraficoPage> createState() => _GraficoPageState();
}

class _GraficoPageState extends State<GraficoPage> {
  List<FlSpot> generateN0Data() {
    List<FlSpot> data = [];
    List<double> x = widget.results["kmvet"];
    List<double> y = widget.results["novet"];

    for (int i = 0; i < x.length; i++) {
      data.add(FlSpot(
        double.parse(x[i].toStringAsFixed(2)),
        double.parse(y[i].toStringAsFixed(2)),
      ));
    }
    return data;
  }

  (double x, double y) calculateGraphProportions() {
    List<double> y1 = widget.results["novet"];
    List<double> x = widget.results["kmvet"];

    double maxY = y1.reduce(max);
    return (x.reduce(max), maxY);
  }

  (double dX, double dY) calculateDelta() {
    List<double> y1 = widget.results["novet"];
    List<double> x = widget.results["kmvet"];

    double minY = y1.reduce(min);
    return (x[1], minY);
  }

  @override
  Widget build(BuildContext context) {
    var (maxX, maxY) = calculateGraphProportions();
    var (minX, minY) = calculateDelta();
    calculateDelta();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Text(
                  "Perfil da concentração de coliformes ao longo da distância - N (org/100 mL)",
                  style: AppTextStyles.h1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Text("OD (mg/L)", style: AppTextStyles.h2),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .7,
                      width: MediaQuery.of(context).size.width * .9,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: maxX + minX,
                          minY: 0,
                          maxY: maxY + minY,
                          clipData: const FlClipData.all(),
                          backgroundColor: const Color(0xfffefefe),
                          titlesData: LineTitles.getTitleData(),
                          gridData: FlGridData(
                            show: true,
                            getDrawingHorizontalLine: (value) => const FlLine(
                              color: Color.fromARGB(68, 121, 131, 141),
                              strokeWidth: 1,
                            ),
                            drawVerticalLine: true,
                            getDrawingVerticalLine: (value) => const FlLine(
                              color: Color.fromARGB(68, 121, 131, 141),
                              strokeWidth: 1,
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: const Color(0xff37434d),
                              width: 1,
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: generateN0Data(),
                              color: const Color(0xff23b6e6),
                              barWidth: 5,
                              // isCurved: true,
                              // preventCurveOverShooting: true,
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: widget.n0GradientColors,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //  swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                        //  swapAnimationCurve: Curves.linear,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Distância (KM)",
                  style: AppTextStyles.h2,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: widget.n0GradientColors.first,
                  radius: 5,
                ),
                const SizedBox(width: 2),
                const Text("N0"),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 18.0),
            ButtonBar(
              children: [
                OutlinedButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.accent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                  ),
                  child: Text(
                    "Calcular novamente",
                    style: AppTextStyles.h3.copyWith(
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
