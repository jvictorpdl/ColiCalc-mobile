import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// Função para formatar os rótulos do eixo Y
String formatYAxisLabel(double value) {
  if (value == 0.0) return '1,00E+00';
  int exponent = log(value) ~/ ln10;
  // double baseValue = value / pow(10, exponent);
  String formattedCoefficient = '1,00';
  String formattedExponentString = exponent >= 0 ? '+$exponent' : '$exponent';
  return '$formattedCoefficient E$formattedExponentString';
}

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
