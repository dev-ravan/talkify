import 'package:talkify/constants/app_images.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/utils/exports.dart';

class UserTile extends StatelessWidget {
  final UserModel user;
  const UserTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
        height: 80,
        padding: p8,
        margin: const EdgeInsets.only(bottom: 12),
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
                child: user.photo != ""
                    ? Image.network(
                        user.photo,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
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
                    user.name,
                    style: textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  gap4,
                  Text(
                    user.email,
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
