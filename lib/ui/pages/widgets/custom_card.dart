import 'package:auto_depura/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum CustomCardAction { previous, next }

String convertToPercentage(double value) {
  // Multiplica o valor por 100 para converter para porcentagem
  double percentage = value * 100;
  // Formata o resultado para três casas decimais
  String formattedPercentage =
      percentage.toStringAsFixed(3).replaceAll('.', ',');
  // Adiciona o símbolo de porcentagem
  return "$formattedPercentage%";
}

class CustomCard extends StatelessWidget {
  final String title;
  final String singleButtonText;
  final String nextButtonText;
  final String confirmButton;
  final Function(CustomCardAction) onPressed;
  final bool
      showButtons; // Adicionado parâmetro para controlar a exibição dos botões
  final double? height; // Adicionado parâmetro para altura
  final List<Widget> children; // Moveu para o final da lista de argumentos

  const CustomCard({
    super.key,
    required this.title,
    required this.onPressed,
    this.singleButtonText = "",
    this.confirmButton = "",
    this.nextButtonText = "Próximo",
    this.showButtons = true, // Valor padrão é true para exibir os botões
    this.height, // Altura opcional
    required this.children, // Moveu para o final da lista de argumentos
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppPaddings.smallest,
        horizontal: AppPaddings.minimum,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(
          width: .2,
          color: const Color(0xfff4f4f4),
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 10),
            spreadRadius: -8,
            blurRadius: 20,
            color: Colors.black.withOpacity(.2),
          )
        ],
      ),
      height: height, // Aplica a altura se fornecida
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.h2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          for (Widget child in children)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 6,
              ),
              child: child,
            ),
          if (showButtons) // Verifica se os botões devem ser exibidos
            ButtonBar(
              children: [
                if (singleButtonText.isEmpty)
                  OutlinedButton(
                    onPressed: () => onPressed(CustomCardAction.previous),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: BorderSide(
                          color: AppColors.accent,
                          style: BorderStyle.solid,
                          width: 5,
                        ),
                      ),
                    ),
                    child: const Text("Voltar"),
                  ),
                ElevatedButton(
                  onPressed: () => onPressed(CustomCardAction.next),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    singleButtonText.isEmpty
                        ? nextButtonText
                        : singleButtonText,
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}


// import 'package:auto_depura/ui/theme/app_theme.dart';
// import 'package:flutter/material.dart';

// enum CustomCardAction { previous, next }

// String convertToPercentage(double value) {
//   // Multiplica o valor por 100 para converter para porcentagem
//   double percentage = value * 100;
//   // Formata o resultado para duas casas decimais
//   String formattedPercentage =
//       percentage.toStringAsFixed(3).replaceAll('.', ',');
//   // Adiciona o símbolo de porcentagem
//   return "$formattedPercentage%";
// }

// class CustomCard extends StatelessWidget {
//   final String title;
//   final List<Widget> children;
//   final String singleButtonText;
//   final String nextButtonText;
//   final String confirmButton;
//   final Function(CustomCardAction) onPressed;

//   const CustomCard({
//     super.key,
//     required this.title,
//     required this.children,
//     required this.onPressed,
//     this.singleButtonText = "",
//     this.confirmButton = "",
//     this.nextButtonText = "Próximo",
//     //usar o confirmButton para os casos de ser o ultimo step que substuirá o botão Proximo
//     //por um botão "Confirmar" mas ainda mantendo o botão voltar a esquerda
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(
//         vertical: AppPaddings.smallest,
//         horizontal: AppPaddings.minimum,
//       ),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.white,
//         border: Border.all(
//           width: .2,
//           color: const Color(0xfff4f4f4),
//         ),
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, 10),
//             spreadRadius: -8,
//             blurRadius: 20,
//             // blurStyle: BlurStyle.outer,
//             color: Colors.black.withOpacity(.2),
//           )
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: AppTextStyles.h2.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           for (Widget child in children)
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 6,
//               ),
//               child: child,
//             ),
//           ButtonBar(
//             children: [
//               if (singleButtonText.isEmpty)
//                 OutlinedButton(
//                   onPressed: () => onPressed(CustomCardAction.previous),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: AppColors.accent,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                       side: BorderSide(
//                         color: AppColors.accent,
//                         style: BorderStyle.solid,
//                         width: 5,
//                       ),
//                     ),
//                   ),
//                   child: const Text("Voltar"),
//                 ),
//               ElevatedButton(
//                 onPressed: () => onPressed(CustomCardAction.next),
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                   ),
//                   backgroundColor: AppColors.accent,
//                   foregroundColor: Colors.white,
//                 ),
//                 child: Text(
//                   singleButtonText.isEmpty ? nextButtonText : singleButtonText,
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
