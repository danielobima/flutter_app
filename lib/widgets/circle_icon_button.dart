
import 'package:flutter/material.dart';

import '../utilities/colors.dart';

class CircleIconButton extends StatelessWidget {
  final Function onClick;
  final IconData icon;
  final int iconColor;
  final int bgColor;
  final int splashColor;

  const CircleIconButton(
      {Key? key,
        required this.onClick,
        required this.icon,
        this.iconColor = prussianBlue,
        this.bgColor = 0xffffffff,
        this.splashColor = prussianBlue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: Colors.black.withOpacity(0.16),
          )
        ],
      ),
      child: RawMaterialButton(
        onPressed: () {
          onClick();
        },
        elevation: 2.0,
        fillColor: Color(bgColor),
        child: Icon(
          icon,
          color: Color(iconColor),

        ),
        constraints: BoxConstraints.tight(const Size(45,45)),
        shape: const CircleBorder(),
        splashColor: Color(splashColor),
      ),
    );
  }
}