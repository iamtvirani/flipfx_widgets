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
class FlipFxWidgets extends StatefulWidget {
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

  const FlipFxWidgets({
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
  _FlipFxWidgetsState createState() => _FlipFxWidgetsState();
}

class _FlipFxWidgetsState extends State<FlipFxWidgets>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _hoverScaleAnimation;
  late Animation<double> _hoverShakeAnimation;
  late AnimationController _hoverController;
  bool _isHovered = false;

  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // Animation for the rotation angle
    _animation = Tween<double>(begin: 0.0, end: 3.14).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    // Initialize hover animation controller
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300), // Hover animation duration
      vsync: this,
    );

    // Scale animation for hover effect (scale between 1.0 and 1.05)
    _hoverScaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
    );

    // Shake animation for hover effect (rotate slightly between 0.0 and 0.03 radians)
    _hoverShakeAnimation = Tween<double>(begin: 0.0, end: 0.03).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeInOut),
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
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true; // Card is hovered
        });
        _hoverController.repeat(reverse: true); // Start hover animation
      },
      // Reset hover animations when the mouse exits
      onExit: (_) {
        setState(() {
          _isHovered = false; // Card is no longer hovered
        });
        _hoverController.reset(); // Stop hover animation
      },
      child: GestureDetector(
        onTap: _onCardTap,
        onLongPress: () {
          setState(() {
            _isHovered = true;
          });
          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              _isHovered = false; // Reset hover effect
            });
          });
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final double shake = _isHovered
                ? _hoverShakeAnimation.value
                : 0.0; // Apply shake if hovered
            final double scale = _isHovered
                ? _hoverScaleAnimation.value
                : 1.0; // Apply scale if hovered

            return Transform(
              alignment: Alignment.center, // Center transformations
              transform: Matrix4.identity()
                ..rotateZ(shake) // Apply shake transformation
                ..scale(scale),
              child: Stack(
                alignment: Alignment.center,
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
                        height: widget.frontWidgetSize?.height,
                        width: widget.frontWidgetSize?.width,
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
                        height: widget.backWidgetSize?.height,
                        width: widget.backWidgetSize?.width,
                        child: widget.backWidget,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
