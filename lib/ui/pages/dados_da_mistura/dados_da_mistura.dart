import 'package:auto_depura/ui/pages/dados_da_mistura/steps/dados_da_mistura_step1.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:auto_depura/ui/widgets/app_title.dart';
import 'package:flutter/material.dart';

class DadosDaMisturaPage extends StatefulWidget {
  const DadosDaMisturaPage({super.key});

  @override
  State<DadosDaMisturaPage> createState() => _DadosDaMisturaPageState();
}

class _DadosDaMisturaPageState extends State<DadosDaMisturaPage> {
  int index = 0;
  void onPressed(CustomCardAction action) {
    Navigator.of(context).pushReplacementNamed("/home");
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
                DadosDaMisturaStep1(onPressed: onPressed),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
