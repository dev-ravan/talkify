import 'package:talkify/features/authentication/presentation/components/pick_user_img.dart';
import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/toasts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  //
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final confirmPwController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    confirmPwController.dispose();
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorTheme = Theme.of(context).colorScheme;

    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => true,
      listener: (context, state) {
        if (state is RegisterToLoginClickState) {
          Navigator.pop(context);
        } else if (state is AuthRegisterSuccessState) {
          successToastMsg(msg: "User added successfully", context: context);
          Navigator.pop(context);
        } else if (state is AuthRegisterFailureState) {
          warningToastMsg(msg: state.error, context: context);
        }
      },
      builder: (context, state) {
        return Center(
          child: SingleChildScrollView(
            child: SafeArea(
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
                      AppStrings.register,
                      style: textTheme.headlineMedium,
                    ),
                    gap8,
                    InkWell(
                      onTap: () => context
                          .read<AuthBloc>()
                          .add(RegisterToLoginClickEvent()),
                      child: RichText(
                        text: TextSpan(
                            text: AppStrings.alreadyHaveAccount,
                            style: textTheme.labelLarge,
                            children: [
                              TextSpan(
                                  text: AppStrings.login,
                                  style: textTheme.labelLarge!.copyWith(
                                    color: colorTheme.primary,
                                    fontWeight: FontWeight.w600,
                                  ))
                            ]),
                      ),
                    ),
                    gap32,
                    // Form Fields
                    // Pick img field
                    const PickUserImage(), gap24,
                    // Name Field
                    CommonField(
                        title: AppStrings.nameField,
                        icon: AppIcons.user,
                        controller: nameController),
                    gap12,
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
                    gap12,
                    // Confirm Password Field
                    CommonField(
                        title: AppStrings.confirmPw,
                        icon: AppIcons.lock,
                        isPassword: true,
                        controller: confirmPwController),

                    gap24,
                    // Buttons
                    AuthButton(
                      isLoading: state is AuthRegisterLoadingState,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          final userPhoto = state is RegisterPickImgSuccessState
                              ? state.image
                              : null;
                          if (pwController.text != confirmPwController.text) {
                            warningToastMsg(
                                msg: "Both password should be same..!",
                                context: context);
                          } else {
                            if (userPhoto != null) {
                              context.read<AuthBloc>().add(
                                  RegisterButtonClickEvent(
                                      name: nameController.text.trim(),
                                      email: emailController.text.trim(),
                                      password: pwController.text.trim(),
                                      photo: userPhoto));
                            } else {
                              warningToastMsg(
                                  msg: "No image selected", context: context);
                            }
                          }
                        }
                      },
                      title: AppStrings.register,
                    ),

                    gap12,
                  ],
                ),
              ),
            )),
          ),
        );
      },
    ));
  }
}
