import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CheckButton extends StatelessWidget {
  final Color color;
  final num width, height;
  final String route;
  final Widget textWidget;
  final bool notUseRoute;

  const CheckButton({
    required this.width,
    required this.height,
    required this.color,
    required this.route,
    required this.textWidget,
    required this.notUseRoute,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (notUseRoute == false) {
          context.go(route);
        }
      },
      child: Container(
        width: width.w,
        height: height.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: Center(child: textWidget),
      ),
    );
  }
}
