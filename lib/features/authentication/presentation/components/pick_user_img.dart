import 'dart:io';

import 'package:talkify/utils/exports.dart';
import 'package:talkify/utils/toasts.dart';

class PickUserImage extends StatelessWidget {
  const PickUserImage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current is AuthActionState,
      buildWhen: (previous, current) => current is! AuthActionState,
      listener: (context, state) {
        if (state is RegisterPickImgFailureState) {
          warningToastMsg(msg: state.msg, context: context);
        }
      },
      builder: (context, state) {
        return Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              context.read<AuthBloc>().add(RegisterPickImgEvent());
            },
            child: Container(
                height: 150,
                width: 150,
                padding: p4,
                decoration: BoxDecoration(
                  border: Border.all(color: colorTheme.outline),
                  color: colorTheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: state is RegisterPickImgSuccessState
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.file(
                          File(state.image.path),
                          fit: BoxFit.cover,
                        ),
                      )
                    : Icon(
                        Icons.camera_alt_outlined,
                        size: 70,
                        color: colorTheme.outline,
                      )),
          ),
        );
      },
    );
  }
}
