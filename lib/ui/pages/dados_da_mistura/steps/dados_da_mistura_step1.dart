import 'package:auto_depura/core/bloc/global_bloc.dart';
import 'package:auto_depura/core/extensions/double_to_input_text.dart';
import 'package:auto_depura/core/extensions/string_to_double.dart';
import 'package:auto_depura/core/services/service_locator.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
import 'package:auto_depura/ui/pages/widgets/or_text_cc.dart';
import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:auto_depura/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class DadosDaMisturaStep1 extends StatefulWidget {
  final Function(CustomCardAction) onPressed;
  const DadosDaMisturaStep1({super.key, required this.onPressed});

  @override
  State<DadosDaMisturaStep1> createState() => _DadosDaMisturaStep1State();
}

class _DadosDaMisturaStep1State extends State<DadosDaMisturaStep1> {
  late final TextEditingController controller1;
  final GlobalBloc bloc = serviceLocator<GlobalBloc>();

  @override
  void initState() {
    controller1 = TextEditingController(text: bloc.nop.toText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          title: "Dados da mistura",
          singleButtonText: "Concluir",
          onPressed: (action) {
            if (controller1.text.isNotEmpty) {
              widget.onPressed(action);
              bloc.nop = controller1.text.asDouble;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Dados incompletos"),
                backgroundColor: Colors.red,
              ));
            }
          },
          children: [
            CustomInput(
              controller: controller1,
              tooltip:
                  "Concentração máxima permissível de coliformes no ponto de mistura em função da legislação ambiental",
              title: "Nop",
              hintText: "org/100 mL",
            ),
          ],
        ),
        const SizedBox(height: 20),
        CustomCard(
          title: "Clique para auxílio em θ para Kb",
          singleButtonText: "Ajuda",
          onPressed: (action) {
            showDialog(
              context: context,
              builder: (context) => Dialog(
                child: Container(
                  padding: const EdgeInsets.all(AppPaddings.defaultPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Auxílio em θ para Kb",
                        style: AppTextStyles.h1.copyWith(
                          color: Colors.black,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      RichText(
                        text: TextSpan(
                          style: AppTextStyles.h3,
                          text: "",
                          children: [
                            TextSpan(
                              text: "Valor usual de θ é de 1,07.\n",
                              style: AppTextStyles.h3.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                                text:
                                    "Arceivala, 1981; EPA, 1985; Thomann e Mueller, 1987 apud Von Sperling, 2005\n",
                                style: AppTextStyles.font.copyWith(
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          children: const [],
        ),
      ],
    );
  }
}
