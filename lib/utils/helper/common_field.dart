// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkify/utils/exports.dart';

class CommonField extends StatelessWidget {
  final String title;
  final String icon;
  final TextEditingController controller;
  final bool isPassword;
  const CommonField(
      {super.key,
      required this.title,
      required this.icon,
      required this.controller,
      this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: colorTheme.outline),
          color: colorTheme.secondary,
          borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: SvgPicture.asset(
          icon,
          height: 24,
          width: 24,
          color: colorTheme.primaryContainer,
        ),
        title: Text(title, style: textTheme.labelLarge),
        subtitle: TextFormField(
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(fontWeight: FontWeight.w600),
          obscureText: isPassword,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Fill required field $title";
            }
            return null;
          },
        ),
      ),
    );
  }
}
