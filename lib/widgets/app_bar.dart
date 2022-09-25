
import 'package:flutter/material.dart';

class PrevAppBar extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Function refresh;

  const PrevAppBar(
      {Key? key, this.icon = Icons.home_filled, this.iconColor = Colors.white, required this.refresh})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 40,
            color: iconColor,
          ),
          const Spacer(),



          // Container(
          //   child: const CircleAvatar(
          //     backgroundImage: AssetImage('assets/images/daniel.JPG'),
          //     radius: 30,
          //   ),
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     shape: BoxShape.circle,
          //     boxShadow: [
          //       BoxShadow(
          //           blurRadius: 6,
          //           color: Colors.black.withOpacity(0.16),
          //           spreadRadius: 3)
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}