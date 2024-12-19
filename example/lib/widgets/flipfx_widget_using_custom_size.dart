import 'package:flipfx_widgets/flipfx_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FlipFXWidgetUsingCustomSize extends StatelessWidget {
  bool isHorizontal;

  FlipFXWidgetUsingCustomSize({super.key, this.isHorizontal = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlipFxWidgets(
          flipDirection: isHorizontal ? FlipDirection.horizontal : FlipDirection.vertical,
          onTap: () {
            if (kDebugMode) {
              print('Card flipped!');
            }
          },
          backWidgetSize: Size(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 3),
          frontWidgetSize: Size(MediaQuery.of(context).size.width / 3, MediaQuery.of(context).size.width / 3),
          frontWidget: Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img.png',
                  fit: BoxFit.fill,
                ),
                Text(
                  'Hello World :)',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
          backWidget: Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img.png',
                  fit: BoxFit.fill,
                ),
                Text(
                  'Hello World :)',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
