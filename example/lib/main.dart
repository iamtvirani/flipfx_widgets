import 'package:example/widgets/flip_widget_horizontal_default_size.dart';
import 'package:example/widgets/flip_widget_vertical_default_size.dart';
import 'package:example/widgets/flip_widget_using_horizontal_custom_size.dart';
import 'package:example/widgets/flip_widget_using_vertical_custom_size.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlipCardExample());

class FlipCardExample extends StatelessWidget {
  const FlipCardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flip Widgets Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Center(
            child: Builder(
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 20,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FlipWidgetUsingVerticalCustomSize(),
                          ),
                        );
                      },
                      child: Text(
                        'Flip Widget Using vertical direction with CustomSize',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FlipWidgetUsingHorizontalCustomSize(),
                          ),
                        );
                      },
                      child: Text(
                        'Flip Widget Using Horizontal direction with CustomSize',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FlipWidgetVerticalDefaultSize(),
                          ),
                        );
                      },
                      child: Text(
                        'Flip Widget Using vertical direction with default size',
                        textAlign: TextAlign.center,
                      ),
                    ),ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => FlipWidgetHorizontalDefaultSize(),
                          ),
                        );
                      },
                      child: Text(
                        'Flip Widget Using Horizontal direction with default size',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
