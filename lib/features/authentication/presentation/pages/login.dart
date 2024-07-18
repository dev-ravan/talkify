import 'package:talkify/features/authentication/presentation/pages/sign_up.dart';
import 'package:talkify/features/home/presentation/pages/home.dart';
import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/toasts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

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
        buildWhen: (previous, current) => true,
        listener: (context, state) {
          if (state is LoginLetsGoSuccessState) {
            successToastMsg(msg: "Logged in successfully! ", context: context);
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          } else if (state is LoginLetsGoFailureState) {
            warningToastMsg(msg: state.error, context: context);
          } else if (state is LoginToRegisterState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpPage()));
          } else if (state is LoginGoogleFailureState) {
            warningToastMsg(msg: state.error, context: context);
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLetsGoLoadingState;
          // if (state is LoginGoogleLoadingState) {
          //   showDialog(
          //     context: context,
          //     builder: (context) => const AlertDialog(
          //       content: Center(
          //         child: CircularProgressIndicator.adaptive(),
          //       ),
          //     ),
          //   );
          // }
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
                  InkWell(
                    onTap: () =>
                        context.read<AuthBloc>().add(LoginCreateItClickEvent()),
                    child: RichText(
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

                  gap24,
                  // Buttons
                  AuthButton(
                    isLoading: isLoading,
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
                    onTap: () {
                      context.read<AuthBloc>().add(LoginGoogleClickEvent());
                    },
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
