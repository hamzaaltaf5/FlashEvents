import 'package:flutter/material.dart';

class LikeAnimations extends StatefulWidget {
  Widget? child;
  bool? isAnimating;
  Duration? duration;
  VoidCallback? onEnd;
  bool? smallLike;

  _LikeAnimationState createState() => _LikeAnimationState();

  LikeAnimations({
    this.child,
    this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  });
}

class _LikeAnimationState extends State<LikeAnimations>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: widget.duration!.inMilliseconds ~/ 2,
        ));
    scale = Tween<double>(begin: 1, end: 1.2).animate(controller);
  }

  @override
  void didUpdateWidget(covariant LikeAnimations oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(widget.isAnimating != oldWidget.isAnimating){
      startAnimation();
    }
  }

  startAnimation() async {
    if(widget.isAnimating! || widget.smallLike!){
      await controller.forward();
      await controller.reverse();
      await Future.delayed(const Duration(milliseconds: 200,));

      if(widget.onEnd != null){
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child,
    );
  }
}
