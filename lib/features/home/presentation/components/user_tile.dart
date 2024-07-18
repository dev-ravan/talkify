import 'package:talkify/constants/app_images.dart';
import 'package:talkify/utils/exports.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
        height: 80,
        padding: p8,
        decoration: BoxDecoration(
          border: Border.all(color: colorTheme.outline),
          color: colorTheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 70,
                height: double.maxFinite,
                child: Image.asset(
                  AppImages.person,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            gap12,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Velmurugan",
                    style: textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  gap4,
                  Text(
                    "velmurugan@gmail.com",
                    style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colorTheme.primaryContainer),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
