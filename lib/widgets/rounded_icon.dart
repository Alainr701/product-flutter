import 'package:flutter/material.dart';

class RoundedIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function onPressed;

  const RoundedIcon(
      {Key? key,
      required this.icon,
      this.color = Colors.black38,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onPressed(),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          alignment: Alignment.center,
          decoration: BoxDecoration(color: this.color, shape: BoxShape.circle),
          child: Icon(this.icon, color: Colors.white)),
    );
  }
}
