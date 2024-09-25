import 'dart:math';
import 'package:flutter/material.dart';


class GuessMyNumber extends StatefulWidget {
  @override
  _GuessMyNumberState createState() => _GuessMyNumberState();
}

class _GuessMyNumberState extends State<GuessMyNumber> {
  final _controller = TextEditingController();
  final _random = Random();
  late int _targetNumber;
  String _message = '';

  @override
  void initState() {
    super.initState();
    _targetNumber = _random.nextInt(100) + 1;
  }

  void _guessNumber() {
    final guess = int.tryParse(_controller.text);
    if (guess == null) {
      setState(() {
        _message = 'Please enter a number';
      });
      return;
    }

    if (guess < _targetNumber) {
      setState(() {
        _message = 'Try higher!';
      });
    } else if (guess > _targetNumber) {
      setState(() {
        _message = 'Try lower!';
      });
    } else {
      setState(() {
        _message = 'You guessed right!';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess My Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('I\'m thinking of a number between 1 and 100.'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter your guess'),
              onSubmitted: (_) => _guessNumber(),
            ),
            ElevatedButton(
              onPressed: _guessNumber,
              child: Text('Guess'),
            ),
            Text(_message),
          ],
        ),
      ),
    );
  }
}