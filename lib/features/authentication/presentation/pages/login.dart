import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkify/constants/app_icons.dart';
import 'package:talkify/features/authentication/presentation/components/auth_button.dart';
import 'package:talkify/features/authentication/presentation/components/icon_button.dart';
import 'package:talkify/features/authentication/presentation/components/remeber_me.dart';
import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/helper/common_field.dart';
import 'package:talkify/utils/sizes.dart';
import 'package:talkify/utils/toasts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //
  final formKey = GlobalKey<FormState>(); //
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  //
  bool isChecked = false;
  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listenWhen: (previous, current) => current is AuthActionState,
        buildWhen: (previous, current) => current is! AuthActionState,
        listener: (context, state) {
          if (state is LoginLetsGoSuccessState) {
            successToastMsg(msg: "Logged in successfully! ", context: context);
          } else if (state is LoginLetsGoFailureState) {
            warningToastMsg(msg: state.error, context: context);
          }
        },
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: p16,
            child: Form(
              key: formKey,
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
                  RememberMe(
                    isCheck: isChecked,
                    forgotClick: () {},
                    onCheckChange: (isCheck) {},
                  ),
                  gap24,
                  // Buttons
                  AuthButton(
                    isLoading: state is LoginLetsGoLoadingState,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(
                              LoginLetsGoButtonClickEvent(
                                email: emailController.text.trim(),
                                password: pwController.text.trim(),
                              ),
                            );
                      }
                    },
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
            ),
          ));
        },
      ),
    );
  }
}
