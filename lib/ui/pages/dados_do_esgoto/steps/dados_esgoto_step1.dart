import 'package:auto_depura/core/bloc/global_bloc.dart';
import 'package:auto_depura/core/extensions/double_to_input_text.dart';
import 'package:auto_depura/core/extensions/string_to_double.dart';
import 'package:auto_depura/core/services/service_locator.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:auto_depura/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class DadosEsgotoStep1 extends StatefulWidget {
  final Function(CustomCardAction) onPressed;
  const DadosEsgotoStep1({super.key, required this.onPressed});

  @override
  State<DadosEsgotoStep1> createState() => _DadosEsgotoStep1State();
}

class _DadosEsgotoStep1State extends State<DadosEsgotoStep1> {
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  final GlobalBloc bloc = serviceLocator<GlobalBloc>();

  @override
  void initState() {
    controller1 = TextEditingController(text: bloc.qe.toText);
    controller2 = TextEditingController(text: bloc.ne.toText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          title: "Dados do Esgoto",
          onPressed: (action) {
            if (controller1.text.isNotEmpty && controller2.text.isNotEmpty) {
              widget.onPressed(action);
              bloc.qe = controller1.text.asDouble;
              bloc.ne = controller2.text.asDouble;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Dados incompletos"),
                backgroundColor: Colors.red,
              ));
            }
          },
          children: [
            CustomInput(
              tooltip: "Vazão do esgoto",
              controller: controller1,
              title: "Qe",
              hintText: "m³/s",
            ),
            CustomInput(
              tooltip: "Oxigênio dissolvido",
              controller: controller2,
              title: "Ne",
              hintText: "org/100mL",
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
