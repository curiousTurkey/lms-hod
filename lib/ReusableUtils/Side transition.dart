import 'package:flutter/material.dart';


class CustomPageRouteSide extends PageRouteBuilder{
  final Widget child;

  CustomPageRouteSide({required this.child}):
        super(
        transitionDuration: const Duration(milliseconds: 200),
        reverseTransitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (context , animation , secondaryAnimation) => child,
      );
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(position: Tween<Offset>(
        begin:const Offset(-2,0),
        end: Offset.zero,
      ).animate(animation),
        child: child,
      );
}