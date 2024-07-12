import 'package:talkify/constants/app_icons.dart';
import 'package:talkify/features/authentication/presentation/components/auth_button.dart';
import 'package:talkify/features/authentication/presentation/components/icon_button.dart';
import 'package:talkify/features/authentication/presentation/components/remeber_me.dart';
import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/helper/common_field.dart';
import 'package:talkify/utils/sizes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;
    //
    final emailController = TextEditingController();
    final pwController = TextEditingController();
    //
    bool isChecked = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: p16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome msg
            Text(
              AppStrings.welcomeTxt,
              style: textTheme.headlineMedium,
            ),
            gap8,
            RichText(
              text: TextSpan(
                  text: AppStrings.dontHaveTxt,
                  style: textTheme.labelLarge,
                  children: [
                    TextSpan(
                        text: AppStrings.createIt,
                        style: textTheme.labelLarge!.copyWith(
                          color: colorTheme.primary,
                          fontWeight: FontWeight.w600,
                        ))
                  ]),
            ),
            gap32,
            // Form Fields
            // Email Field
            CommonField(
                title: AppStrings.emailField,
                icon: AppIcons.at,
                controller: emailController),
            gap12,
            // Password Field
            CommonField(
                title: AppStrings.pwField,
                icon: AppIcons.lock,
                isPassword: true,
                controller: pwController),
            gap8,
            // Remember me
            RemeberMe(
              isCheck: isChecked,
              forgotClick: () {},
              onCheckChange: (isCheck) {},
            ),
            gap24,
            // Buttons
            AuthButton(
              onTap: () {},
              title: AppStrings.letsGo,
            ),
            gap32,
            CommonButton(
              color: Palettes.redColor,
              title: AppStrings.google,
              icon: AppIcons.google,
              onTap: () {},
            ),
            gap12,

            CommonButton(
              color: Palettes.blueColor,
              title: AppStrings.facebook,
              icon: AppIcons.facebook,
              onTap: () {},
            ),
            gap12,
          ],
        ),
      )),
    );
  }
}
