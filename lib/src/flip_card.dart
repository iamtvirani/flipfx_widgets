import 'package:flutter/material.dart';

/// FlipDirection enum to define the direction of the flip.
enum FlipDirection {
  /// Flip along the X-axis (vertical flip).
  vertical,

  /// Flip along the Y-axis (horizontal flip).
  horizontal,
}

/// A customizable FlipCard widget for flipping between two widgets.
///
/// This widget allows creating cards that can flip in vertical or horizontal directions.
/// [frontWidget] represents the front side of the card.
/// [backWidget] represents the back side of the card.
class FlipCard extends StatefulWidget {
  /// Direction of the flip: vertical or horizontal.
  final FlipDirection? flipDirection;

  /// Callback triggered when the card is tapped.
  final VoidCallback onTap;

  /// The widget displayed on the front side of the card.
  final Widget frontWidget;

  /// The widget displayed on the back side of the card.
  final Widget backWidget;

  /// Custom size for the front widget (optional).
  final Size? frontWidgetSize;

  /// Custom size for the back widget (optional).
  final Size? backWidgetSize;

  /// Duration of the flip animation (default is 800ms).
  final Duration duration;

  const FlipCard({
    Key? key,
     this.flipDirection,
     required this.onTap,
    required this.frontWidget,
    required this.backWidget,
    this.frontWidgetSize,
    this.backWidgetSize,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();

    // Animation controller for the flip animation
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Animation for the rotation angle
    _animation = Tween<double>(begin: 0.0, end: 3.14).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  /// Toggles the flip animation and triggers the callback.
  void _onCardTap() {
    widget.onTap();
    if (_isFlipped) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onCardTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            children: [
              // Front widget
              Transform(
                transform: widget.flipDirection == FlipDirection.vertical
                    ? Matrix4.rotationX(_animation.value)
                    : Matrix4.rotationY(_animation.value),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: _animation.value <= 3.14 / 2 ? 1.0 : 0.0,
                  child: SizedBox(
                    height: widget.frontWidgetSize?.height ?? 200,
                    width: widget.frontWidgetSize?.width ?? 150,
                    child: widget.frontWidget,
                  ),
                ),
              ),

              // Back widget
              Transform(
                transform: widget.flipDirection == FlipDirection.vertical
                    ? Matrix4.rotationX(_animation.value - 3.14)
                    : Matrix4.rotationY(_animation.value - 3.14),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: _animation.value > 3.14 / 2 ? 1.0 : 0.0,
                  child: SizedBox(
                    height: widget.backWidgetSize?.height ?? 200,
                    width: widget.backWidgetSize?.width ?? 150,
                    child: widget.backWidget,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
