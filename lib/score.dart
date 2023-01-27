import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'styled_button.dart';

class Score extends StatelessWidget {
  const Score(
      {super.key,
      required this.totralScore,
      required this.round,
      required this.onResetPressed});

  final int totralScore;
  final int round;
  final VoidCallback onResetPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StyledButton(
            icon: Icons.refresh,
            onPressed: () {
              onResetPressed();
            }),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Row(
            children: [
              Text('Score:', style: LabelTextStyle.bodyText1(context)),
              Text('$totralScore',
                  style: ScoreNumberTextStyle.headline4(context)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Row(
            children: [
              Text('Round:', style: LabelTextStyle.bodyText1(context)),
              Text('$round', style: ScoreNumberTextStyle.headline4(context)),
            ],
          ),
        ),
        StyledButton(icon: Icons.info, onPressed: () {})
      ],
    );
  }
}
