import 'package:flipfx_widgets/flipfx_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlipFXWidgetDefaultSize extends StatelessWidget {
  bool isHorizontal;

  FlipFXWidgetDefaultSize({super.key, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            3,
            (index) => FlipFxWidgets(
              flipDirection: isHorizontal
                  ? FlipDirection.horizontal
                  : FlipDirection.vertical,
              onTap: () {
                if (kDebugMode) {
                  print('Card flipped!');
                }
              },
              frontWidget: Container(
                color: Colors.blue.withOpacity(0.5),
                child: Center(
                    child: Image.asset(
                  'assets/img_1.png',
                  fit: BoxFit.fill,
                )),
              ),
              backWidget: Container(
                color: Colors.pink.withOpacity(0.5),
                child: Center(
                    child: Image.asset(
                  'assets/img_2.png',
                  fit: BoxFit.fill,
                )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
