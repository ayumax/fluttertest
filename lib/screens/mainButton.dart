import 'package:flutter/material.dart';

class TopButton extends Column {
  final Color color;
  final IconData icon;
  final String label;

  TopButton(this.color, this.icon, this.label)
      : super(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: color,
                ),
              ),
            ),
          ],
        );
}
