import 'dart:math';
import 'dart:ui';
import 'package:auto_depura/core/bloc/global_bloc.dart';
import 'package:auto_depura/core/services/service_locator.dart';
import 'package:auto_depura/ui/pages/grafico/line_titles.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
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
  double maxX = 0, maxY = 0;
  double minX = 0, minY = 0;

  String formatScientific(double value) {
    String exponentialForm = value.toStringAsExponential(2);
    List<String> parts = exponentialForm.split('e');
    String coefficient =
        double.parse(parts[0]).toStringAsFixed(2).replaceAll('.', ',');
    int exponent = int.parse(parts[1]);
    String sign = exponent >= 0 ? '+' : '';
    String formattedExponentString = exponent.abs().toString().padLeft(2, '0');
    return '$coefficient E$sign$formattedExponentString';
  }

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

  final GlobalBloc bloc = serviceLocator<GlobalBloc>();

  @override
  Widget build(BuildContext context) {
    if (!bloc.represa) {
      var resultProportions = calculateGraphProportions();
      var resultDelta = calculateDelta();
      maxX = resultProportions.$1;
      maxY = resultProportions.$2;
      minX = resultDelta.$1;
      minY = resultDelta.$2;
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            !bloc.represa
                ? Column(
                    children: [
                      Text(
                        "Perfil da concentração de coliformes ao longo da distância - N (org/100 mL)",
                        style: AppTextStyles.titleGraph,
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          RotatedBox(
                            quarterTurns: 1,
                            child:
                                Text("CF (org/100ml)", style: AppTextStyles.h2),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * .65,
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
                                  getDrawingHorizontalLine: (value) =>
                                      const FlLine(
                                    color: Color.fromARGB(68, 121, 131, 141),
                                    strokeWidth: 1,
                                  ),
                                  drawVerticalLine: true,
                                  getDrawingVerticalLine: (value) =>
                                      const FlLine(
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
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: widget.n0GradientColors,
                                      ),
                                    ),
                                    dotData: FlDotData(show: true),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  touchTooltipData: LineTouchTooltipData(
                                    tooltipBgColor: Colors.blueAccent,
                                    getTooltipItems:
                                        (List<LineBarSpot> touchedSpots) {
                                      return touchedSpots.map((touchedSpot) {
                                        final textStyle = TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        );
                                        final text =
                                            formatScientific(touchedSpot.y) +
                                                " org/100ml";
                                        return LineTooltipItem(text, textStyle);
                                      }).toList();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "Distância (KM)",
                        style: AppTextStyles.h2,
                      ),
                      Text(
                        "Eficiencia de tratamento necessária: ${convertToPercentage(bloc.eficiencia!)}",
                        style: AppTextStyles.h3,
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .80,
                        width: MediaQuery.of(context).size.width * .9,
                        alignment: Alignment.center,
                        child: CustomCard(
                          title: "",
                          onPressed: (action) {
                            Navigator.of(context).pushReplacementNamed("/home");
                          },
                          showButtons: false,
                          height: 250,
                          children: [
                            // Centraliza o texto verticalmente e horizontalmente
                            Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Centraliza verticalmente

                              children: [
                                Text(
                                  'Valor resultante de eficiência: ${convertToPercentage(bloc.eficiencia!)}',
                                  style: AppTextStyles.h1,
                                  textAlign: TextAlign
                                      .center, // Centraliza horizontalmente
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),

            //row retirada pois achei desnecessaria a legenda, mas pode ser adicionada depois caso a orientadora prefira
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     CircleAvatar(
            //       backgroundColor: widget.n0GradientColors.first,
            //       radius: 5,
            //     ),
            //     const SizedBox(width: 2),
            //     const Text("N0 LEGENDA"),
            //     const SizedBox(width: 10),
            //   ],
            // ),
            const SizedBox(height: 18.0),
            ButtonBar(
              children: [
                OutlinedButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed("/home"),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.accent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
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
            ),
          ],
        ),
      ),
    );
  }
}
