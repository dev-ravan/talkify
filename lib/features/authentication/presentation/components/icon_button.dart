// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/sizes.dart';

class CommonButton extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final String icon;
  final String title;
  const CommonButton(
      {super.key,
      required this.color,
      required this.onTap,
      required this.icon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.08,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: Palettes.whiteTxtColor,
              height: 24,
              width: 24,
            ),
            gap12,
            Text(title,
                style: textTheme.bodyLarge!.copyWith(
                    color: Palettes.whiteTxtColor, fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
