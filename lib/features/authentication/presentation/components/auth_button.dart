import 'package:talkify/utils/exports.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const AuthButton({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.08,
        decoration: BoxDecoration(
            color: colorTheme.primary, borderRadius: BorderRadius.circular(8)),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      title,
                      style: textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Palettes.whiteTxtColor),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
                right: 0, // Position the container on the right side
                top: 0, // Align the container to the top
                bottom: 0, // Align the container to the bottom
                child: Container(
                    margin: const EdgeInsets.all(6),
                    width: MediaQuery.sizeOf(context).height / 13,
                    decoration: BoxDecoration(
                        color: Palettes.bgColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6)),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Palettes.whiteTxtColor,
                    ))),
          ],
        ),
      ),
    );
  }
}
