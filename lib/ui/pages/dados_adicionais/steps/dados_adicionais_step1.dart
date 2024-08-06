import 'package:auto_depura/core/bloc/global_bloc.dart';
import 'package:auto_depura/core/extensions/double_to_input_text.dart';
import 'package:auto_depura/core/extensions/string_to_double.dart';
import 'package:auto_depura/core/services/service_locator.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
import 'package:auto_depura/ui/pages/widgets/or_text_cc.dart';
import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:auto_depura/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class DadosAdicionaisStep1 extends StatefulWidget {
  final Function(CustomCardAction) onPressed;
  const DadosAdicionaisStep1({super.key, required this.onPressed});

  @override
  State<DadosAdicionaisStep1> createState() => _DadosAdicionaisStep1State();
}

class _DadosAdicionaisStep1State extends State<DadosAdicionaisStep1> {
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  late final TextEditingController controller3;
  late final TextEditingController controller4;
  late final TextEditingController controller5;
  late final TextEditingController controller6;
  final GlobalBloc bloc = serviceLocator<GlobalBloc>();

  @override
  void initState() {
    controller1 = TextEditingController(text: bloc.temperatura.toText);
    controller2 = TextEditingController(text: bloc.distancia.toText);
    controller3 = TextEditingController(text: bloc.velocidade.toText);
    controller4 = TextEditingController(text: bloc.kb.toText);
    controller5 = TextEditingController(text: bloc.teta.toText);
    controller6 = TextEditingController(text: bloc.particoes.toText);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCard(
          title: "Dados morfométricos e ambientais",
          singleButtonText: "Concluir",
          onPressed: (action) {
            if ((controller1.text.isNotEmpty &&
                    controller2.text.isNotEmpty &&
                    controller3.text.isNotEmpty) ||
                controller4.text.isNotEmpty) {
              widget.onPressed(action);
              bloc.temperatura = controller1.text.asDouble;
              bloc.distancia = controller2.text.asDouble;
              bloc.velocidade = controller3.text.asDouble;
              bloc.kb = controller4.text.asDouble;
              bloc.teta = controller5.text.asDouble;
              bloc.particoes = controller6.text.asDouble;
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
              tooltip: "Temperatura",
              title: "T",
              hintText: "ºC",
            ),
            CustomInput(
              controller: controller2,
              tooltip: "Distância do percurso",
              title: "d",
              hintText: "m",
            ),
            CustomInput(
              controller: controller3,
              tooltip: "Velocidade",
              title: "v",
              hintText: "m/s",
            ),
            // const OrText(),
            CustomInput(
              controller: controller4,
              tooltip: "Coeficiente de decaimento bacteriano",
              title: "Kb",
              hintText: "d⁻¹",
            ),
            CustomInput(
              controller: controller5,
              tooltip: "Coeficiente de temperatura",
              title: "θ para Kb",
              hintText: "d⁻¹",
            ),
            CustomInput(
              controller: controller6,
              tooltip:
                  "Quantidade de segmentos ao longo do percurso a serem analisados",
              title: "Nº trechos",
              hintText: "Quantidade",
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
