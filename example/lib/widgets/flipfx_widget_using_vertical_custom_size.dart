import 'package:flip_widgets/flipfx_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlipFXWidgetUsingVerticalCustomSize extends StatelessWidget {
  const FlipFXWidgetUsingVerticalCustomSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlipFxWidgets(
          flipDirection: FlipDirection.vertical,
          onTap: () {
            if (kDebugMode) {
              print('Card flipped!');
            }
          },
          backWidgetSize: Size(1000, 600),
          frontWidgetSize: Size(600, 60),
          frontWidget: Container(
            color: Colors.blue,
            child: Center(
              child: Text(
                'Front Widget',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
          backWidget: Container(
            color: Colors.red,
            child: Center(
              child: Text(
                'Back Widget',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
