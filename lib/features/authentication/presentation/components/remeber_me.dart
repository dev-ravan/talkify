import 'package:talkify/utils/exports.dart';

class RememberMe extends StatelessWidget {
  final bool isCheck;
  final VoidCallback forgotClick;
  final Function(bool?) onCheckChange;
  const RememberMe(
      {super.key,
      required this.isCheck,
      required this.forgotClick,
      required this.onCheckChange});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Row(
          children: [
            Checkbox.adaptive(
              side: BorderSide(color: colorTheme.primaryContainer),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              value: isCheck,
              onChanged: onCheckChange,
            ),
            Text(AppStrings.rememberMe, style: textTheme.labelLarge),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: forgotClick,
          child: Text(AppStrings.forgotPw,
              style: textTheme.labelLarge!.copyWith()),
        )
      ],
    );
  }
}
