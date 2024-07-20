// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/flutter_svg.dart';
import 'package:talkify/features/home/data/model/user_model.dart';
import 'package:talkify/features/home/presentation/bloc/home_bloc.dart';
import 'package:talkify/utils/exports.dart';

class HomeHeader extends StatelessWidget {
  final UserModel user;
  const HomeHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          // Logout
          Expanded(
            child: InkWell(
              onTap: () {
                context.read<HomeBloc>().add(HomeLogoutClickEvent());
              },
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
                    AppIcons.logout,
                    color: colorTheme.primaryContainer,
                  ),
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
              height: double.maxFinite,
              decoration: BoxDecoration(
                border: Border.all(color: colorTheme.outline),
                color: colorTheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: user.photo != ""
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        user.photo,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Center(
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
