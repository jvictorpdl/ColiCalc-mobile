import 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';

part 'global_event.dart';
part 'global_state.dart';
part 'global_bloc.freezed.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(const _Initial()) {
    on<_Calculate>(_onCalculate);
    setupTest();
  }

  final double neperiano = 2.7182818285;
  double? qr,
      qe,
      temperatura,
      no,
      nop,
      nr,
      ne,
      ntempo,
      nep,
      kb,
      kbt,
      teta,
      eficiencia,
      tempo,
      velocidade,
      distancia,
      particoes,
      classLimit,
      tRepresa,
      tDentencao,
      volume,
      qAfluente,
      nRepresa,
      nRepresaMax;
  bool? represa = false;
  List<double> particoesVet = [];
  List<double> ntempoVet = [];
  List<double> kmvet = [];
  List<double> novet = [];

  bool get checkAllNumbersFilled => represa != null;
  // qr != null &&
  // nr != null &&
  // qe != null &&
  // ne != null &&
  // nop != null &&
  // temperatura != null &&
  // distancia != null &&
  // velocidade != null &&
  // kb != null &&
  // teta != null &&
  // particoes != null;
  // volume != null;

  void _onCalculate(_Calculate event, Emitter<GlobalState> emit) async {
    dev.log("onCalculated chamado");
    emit(const GlobalState.calculating());
    setupTest();
    final results = calcularResultado();
    dev.log("emitindo");
    emit(GlobalState.calculated(results));
  }

  Map<String, dynamic> calcularResultado() {
    particoesVet.clear();
    ntempoVet.clear();
    kmvet.clear();
    novet.clear();

    if (represa == false) {
      // dev.log('ENTROU EM RIO!!!');
      no = ((qr! * nr!) + (qe! * ne!)) / (qr! + qe!);

      kbt = kb! * pow(teta!, (temperatura! - 20));
      if (no! > nop!) {
        nep = (nop! * (qr! + qe!) - qr! * nr!) / qe!;
        eficiencia = (ne! - nep!) / ne!;

        for (double i = 0; i <= particoes!; i++) {
          double tempop =
              ((distancia! / particoes!) * i) / (velocidade! * 86400);
          double noToPush =
              tempop == 0 ? nop! : nop! * pow(neperiano, (-kbt! * tempop));

          double aux = distancia! / particoes!;
          kmvet.add((aux * i) / 1000);
          novet.add(noToPush);
        }
      } else {
        for (double i = 0; i <= particoes!; i++) {
          double tempop =
              ((distancia! / particoes!) * i) / (velocidade! * 86400);
          double noToPush =
              tempop == 0 ? no! : no! * pow(neperiano, (-kbt! * tempop));

          double aux = distancia! / particoes!;
          kmvet.add((aux * i) / 1000);
          novet.add(noToPush);
        }
      }
    } else {
      // dev.log('ENTROU EM REPRESA!!!');
      qAfluente = qr! + qe!;
      kbt = kb! * pow(teta!, (temperatura! - 20));
      tDentencao = volume! / (qAfluente! * 86400);

      nRepresa = nop! * (1 + (kbt! * tDentencao!));

      if (nRepresa! > nop!) {
        nRepresaMax = nop! * (1 + kbt! * tDentencao!);
        nep = (nRepresaMax! * (qr! + qe!) - qr! * nr!) / qe!;
        eficiencia = (ne! - nep!) / ne!;
      } else {
        eficiencia = -1;
      }
    }

    Map<String, dynamic> resultado2 = {
      'eficiencia': convertToPercentage(eficiencia),
      'particoesVet': particoesVet,
      'ntempoVet': ntempoVet,
      'kmvet': kmvet,
      'novet': novet
    };

    return resultado2;
  }

  String convertToPercentage(double? value) {
    if (value == null) return '0%';
    final percentage = value * 100;
    final formattedPercentage =
        percentage.toStringAsFixed(3).replaceAll('.', ',');
    return '$formattedPercentage%';
  }

  void setupTest() {
    qr = 0.651;
    qe = 0.114;
    temperatura = 23;
    no = 0;
    nop = 1000;
    nr = 10;
    ne = 50000000;
    ntempo = 0;
    nep = 0;
    kb = 1;
    kbt = 0;
    teta = 1.07;
    eficiencia = 0;
    tempo = 0;
    velocidade = 0.35;
    distancia = 50000;
    particoes = 10;
    classLimit = 0;
    represa = false;
    tRepresa = 0;
    tDentencao = 0;
    volume = 5000000;
    qAfluente = 0;
    nRepresa = 0;
    nRepresaMax = 0;
  }
}
