import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flip_widgets/flip_widgets.dart';

void main() => runApp(FlipCardExample());

class FlipCardExample extends StatelessWidget {
  const FlipCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flip Card Example'),
        ),
        body: Center(
          child: FlipCard(
            flipDirection: FlipDirection.horizontal,
            onTap: () {
              if (kDebugMode) {
                print('Card flipped!');
              }
            },
            frontWidget: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Front',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            backWidget: Container(
              color: Colors.red,
              child: Center(
                child: Text(
                  'Back',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
