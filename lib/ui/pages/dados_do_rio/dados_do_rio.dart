import 'package:auto_depura/ui/pages/dados_do_rio/steps/dados_rio_step1.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:auto_depura/ui/widgets/app_title.dart';
import 'package:auto_depura/ui/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class DadosDoRioPage extends StatefulWidget {
  const DadosDoRioPage({super.key});

  @override
  State<DadosDoRioPage> createState() => _DadosDoRioPageState();
}

class _DadosDoRioPageState extends State<DadosDoRioPage> {
  int index = 0;
  void onPressed(CustomCardAction action) {
    switch (action) {
      case CustomCardAction.previous:
        if (index >= 1) setState(() => index--);
        break;
      case CustomCardAction.next:
        // se index menor menor ou igual a total de steps - 1:
        Navigator.of(context).pushReplacementNamed("/home");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 18,
          ),
          children: [
            const AppTitle(),
            const SizedBox(height: 30),
            IndexedStack(
              index: index,
              children: [
                DadosRioStep1(onPressed: onPressed),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
