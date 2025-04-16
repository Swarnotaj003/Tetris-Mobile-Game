import 'package:flutter/material.dart';

class GameOverDialog extends StatelessWidget {
  final String score;
  final void Function() restart;

  const GameOverDialog({super.key, required this.score, required this.restart});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Center(
        child: Text(
          'G A M E  O V E R !',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SizedBox(
        height: 90,
        child: Column(
          children: [
            Text(
              'Your score',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              score,
              style: TextStyle(color: Colors.white, fontSize: 40),
            ),
          ],
        ),
      ),
      actions: [
        Align(
          alignment: Alignment.bottomCenter,
          child: TextButton.icon(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(Colors.green[700]),
            ),
            onPressed: () {
              restart();
              Navigator.pop(context);
            },
            icon: Icon(Icons.play_arrow, size: 40, color: Colors.white,),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Text(
                'Play again',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
