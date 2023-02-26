import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_text_theme.dart';

class BoardCard extends StatelessWidget {
  final String title;
  final String? leadingText;
  final Widget? leadingImage;
  final String? trailingText;
  final VoidCallback? onTap;

  const BoardCard(
      {super.key,
      this.leadingText,
      this.leadingImage,
      required this.title,
      this.trailingText,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.all(0),
      visualDensity: VisualDensity(vertical: -3),
      dense: true,
      title: SizedBox(height: 24, child: Text(title, style: regularStyle)),
      leading: leadingImage == null
          ? leadingText == null
              ? const SizedBox()
              : SizedBox(
                  height: 24,
                  child: Text(
                    leadingText!,
                    style: regularStyle.copyWith(color: grey),
                  ))
          : SizedBox(height: 32, width: 32, child: leadingImage),
      trailing: trailingText == null
          ? const SizedBox()
          : Text(
              trailingText!,
              style: regularStyle,
            ),
    );
  }
}
