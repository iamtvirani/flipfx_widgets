import 'package:flutter/material.dart';
import 'package:example/widgets/flipfx_widget_default_size.dart';
import 'package:example/widgets/flipfx_widget_using_custom_size.dart';

void main() {
  runApp(FlipFxWidgetsExample());
}

class FlipFxWidgetsExample extends StatelessWidget {
  const FlipFxWidgetsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlipFxWidgetsScreen(),
    );
  }
}

class FlipFxWidgetsScreen extends StatelessWidget {
  const FlipFxWidgetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlipFX Widgets Example'),
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
                          builder: (context) => FlipFXWidgetUsingCustomSize(isHorizontal: false),
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
                          builder: (context) => FlipFXWidgetUsingCustomSize(
                            isHorizontal: true,
                          ),
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
                          builder: (context) => FlipFXWidgetDefaultSize(isHorizontal: true),
                        ),
                      );
                    },
                    child: Text(
                      'Flip Widget Using vertical direction with default size',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FlipFXWidgetDefaultSize(
                            isHorizontal: false,
                          ),
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
    );
  }
}
