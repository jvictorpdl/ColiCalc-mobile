import 'package:auto_depura/core/bloc/global_bloc.dart';
import 'package:auto_depura/core/extensions/double_to_input_text.dart';
import 'package:auto_depura/core/extensions/string_to_double.dart';
import 'package:auto_depura/core/services/service_locator.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
import 'package:auto_depura/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class DadosRepresaStep1 extends StatefulWidget {
  final Function(CustomCardAction) onPressed;
  const DadosRepresaStep1({super.key, required this.onPressed});

  @override
  State<DadosRepresaStep1> createState() => _DadosRepresaStep1State();
}

class _DadosRepresaStep1State extends State<DadosRepresaStep1> {
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  late final TextEditingController controller3;
  final GlobalBloc bloc = serviceLocator<GlobalBloc>();

  @override
  void initState() {
    controller1 = TextEditingController(text: bloc.qr.toText);
    controller2 = TextEditingController(text: bloc.nr.toText);
    controller3 = TextEditingController(text: bloc.volume.toText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: "Dados da Represa",
      singleButtonText: "Concluir",
      onPressed: (action) {
        if (controller1.text.isNotEmpty &&
            controller2.text.isNotEmpty &&
            controller3.text.isNotEmpty) {
          widget.onPressed(action);
          bloc.qr = controller1.text.asDouble;
          bloc.nr = controller2.text.asDouble;
          bloc.volume = controller3.text.asDouble;
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Dados incompletos"),
            backgroundColor: Colors.red,
          ));
        }
      },
      children: [
        CustomInput(
          tooltip: "Vazão da represa",
          controller: controller1,
          title: "Qr",
          hintText: "m³/s",
        ),
        CustomInput(
          controller: controller2,
          tooltip:
              "Concentração de coliformes no rio, a montante do lançamento",
          title: "Nr",
          hintText: "NMP/100 mL",
        ),
        CustomInput(
          controller: controller3,
          tooltip: "Volume",
          title: "V",
          hintText: "m³",
        ),
      ],
    );
  }
}
