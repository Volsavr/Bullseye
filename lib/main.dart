import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt.dart';
import 'control.dart';
import 'score.dart';
import 'game_model.dart';
import 'dart:math';
import 'hit_me_button.dart';
import 'styled_button.dart';

void main() {
  runApp(const BullsEyeApp());
}

class BullsEyeApp extends StatelessWidget {
  const BullsEyeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return const MaterialApp(
      title: 'Bullseye',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(_generateTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage('images/background.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Prompt(targetValue: _model.target),
              Control(model: _model),
              HitMeButton(text: 'Click me', onPressed: _showAlert),
              Score(
                  totralScore: _model.totalScore,
                  round: _model.round,
                  onResetPressed: _resetGame)
            ],
          ),
        ),
      ),
    );
  }

  int _calculateDifference() => (_model.current - _model.target).abs();

  int _generateTargetValue() => Random().nextInt(101);

  int _pointsForCurrentRound() {
    var extraBonus = 0;
    var difference = _calculateDifference();

    if (difference == 0) {
      extraBonus = 100;
    } else if (difference == 1) {
      extraBonus = 50;
    }

    return 100 - _calculateDifference() + extraBonus;
  }

  String _generateTitle() {
    var difference = _calculateDifference();

    if (difference == 0) {
      return 'Good job!';
    } else if (difference <= 5) {
      return 'You almost had it!';
    } else if (difference <= 10) {
      return 'Not bad.';
    } else {
      return 'Came on! You can better.';
    }
  }

  void _showAlert() {
    var okBtn = StyledButton(
      icon: Icons.close,
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _model.totalScore += _pointsForCurrentRound();
          _model.target = _generateTargetValue();
          _model.round += 1;
        });
      },
    );

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(_generateTitle()),
            content: Text('The slider\' value is ${_model.current}.\n'
                'You scored ${_pointsForCurrentRound()} point this round'),
            actions: [okBtn],
            elevation: 5,
          );
        });
  }

  _resetGame() {
    setState(() {
      _model.round = GameModel.roudStart;
      _model.current = GameModel.sliderStart;
      _model.totalScore = GameModel.scoreStart;
      _model.target = _generateTargetValue();
    });
  }
}
