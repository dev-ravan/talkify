// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkify/utils/exports.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          // Settings
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorTheme.outline),
                color: colorTheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset(
                  height: 24,
                  width: 24,
                  AppIcons.settings,
                  color: colorTheme.primaryContainer,
                ),
              ),
            ),
          ),
          gap12,
          // Title
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorTheme.outline),
                color: colorTheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  AppStrings.appTitle,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: colorTheme.primaryContainer,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          gap12,
          // Profile image
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: colorTheme.outline),
                color: colorTheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  size: 40,
                  color: colorTheme.outline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
