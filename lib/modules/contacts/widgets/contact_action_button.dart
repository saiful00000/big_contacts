import 'package:flutter/material.dart';

class ContactActionButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final Color contentColor;
  final Color color;
  final Function()? onTap;

  const ContactActionButton({
    super.key,
    required this.text,
    required this.iconData,
    required this.contentColor,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: contentColor,
            ),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: contentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
