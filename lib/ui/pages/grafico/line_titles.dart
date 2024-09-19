import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// Função para formatar os rótulos do eixo Y
String formatYAxisLabel(double value) {
  if (value == 0.0) return '1,00E+00'; // Valor para zero.

  // Calcula o expoente baseado no logaritmo de base 10.
  int exponent = log(value) ~/ ln10;

  // Calcula o valor real da potência correspondente ao expoente.
  double realValue = value / pow(10, exponent);

  // Ajuste para sempre iniciar com '1,00'.
  if (realValue != 1.0) {
    // Se o valor normalizado não for 1, ajustamos o expoente.
    exponent += (realValue > 1.0) ? 1 : 0;
  }

  String formattedCoefficient = '1,00'; // Mantém sempre a base '1,00'.
  String formattedExponentString =
      exponent >= 0 ? '+$exponent' : '$exponent'; // Formata o expoente.

  return '$formattedCoefficient E$formattedExponentString';
}
// String formatYAxisLabel(double value) {
//   if (value == 0.0) return '1,00E+00';
//   int exponent = log(value) ~/ ln10;
//   // double baseValue = value / pow(10, exponent);
//   String formattedCoefficient = '1,00';
//   String formattedExponentString = exponent >= 0 ? '+$exponent' : '$exponent';
//   return '$formattedCoefficient E$formattedExponentString';
// }

class LineTitles {
  static getTitleData() => const FlTitlesData(
        show: true,
        topTitles: AxisTitles(
          axisNameSize: 16,
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitles,
            reservedSize: 55,
          ),
        ),
        rightTitles: AxisTitles(
          axisNameSize: 50,
          drawBelowEverything: true,
        ),
      );

  static Widget leftTitles(double value, TitleMeta meta) {
    TextStyle style = AppTextStyles.h3.copyWith(fontSize: 12);
    return Text(
      formatYAxisLabel(value),
      style: style,
      overflow: TextOverflow.visible, // Garante que o texto não será cortado
      softWrap: false, // Garante que o texto não será quebrado em várias linhas
    );
  }
}
