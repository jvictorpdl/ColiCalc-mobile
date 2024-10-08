import 'package:auto_depura/core/bloc/global_bloc.dart';
import 'package:auto_depura/core/services/service_locator.dart';
import 'package:auto_depura/ui/pages/dados_do_esgoto/steps/dados_esgoto_step1.dart';
import 'package:auto_depura/ui/pages/widgets/custom_card.dart';
import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:auto_depura/ui/widgets/app_title.dart';
import 'package:flutter/material.dart';

class DadosDoEsgotoPage extends StatefulWidget {
  const DadosDoEsgotoPage({super.key});

  @override
  State<DadosDoEsgotoPage> createState() => _DadosDoEsgotoPageState();
}

class _DadosDoEsgotoPageState extends State<DadosDoEsgotoPage> {
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
                DadosEsgotoStep1(onPressed: onPressed),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
