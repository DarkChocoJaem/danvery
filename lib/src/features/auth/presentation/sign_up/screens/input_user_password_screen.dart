import 'package:auto_route/annotations.dart';
import 'package:danvery/src/core/utils/auth_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/services/snack_bar/snack_bar_service.dart';
import '../../../../../design_system/orb/components/components.dart';
import '../providers/sign_up_provider.dart';

@RoutePage()
class InputUserPasswordScreen extends ConsumerStatefulWidget {
  final String signUpToken;
  final String nickname;

  const InputUserPasswordScreen({
    super.key,
    required this.signUpToken,
    required this.nickname,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _InputUserPasswordScreenState();
  }
}

class _InputUserPasswordScreenState
    extends ConsumerState<InputUserPasswordScreen> with AuthValidator {
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmController;

  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController = TextEditingController();
    passwordConfirmController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      signUpProvider,
      (previous, next) {
        if (!next.isLoading && next.hasError) {
          ref.read(snackBarServiceProvider).show(
                context,
                type: OrbSnackBarType.error,
                message: next.message!,
              );
        }
      },
    );

    final submitButton = OrbButton(
      onPressed: () async {
        await ref.read(signUpProvider.notifier).signUp(
              formKey,
              signUpToken: widget.signUpToken,
              nickname: widget.nickname,
              password: passwordController.text,
            );
      },
      buttonText: '완료',
    );

    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      body: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '단버리 로그인에\n사용할 비밀번호를 입력해주세요',
              style: themeData.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: passwordController,
              labelText: '비밀번호',
              textInputAction: TextInputAction.next,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                return validatePassword(password: value);
              },
            ),
            const SizedBox(height: 16),
            OrbTextFormField(
              controller: passwordConfirmController,
              labelText: '비밀번호 확인',
              textInputAction: TextInputAction.done,
              maxLength: 20,
              obscureText: true,
              validator: (value) {
                return validatePasswordConfirm(
                  password: passwordController.text,
                  passwordConfirm: value,
                );
              },
            ),
          ],
        ),
      ),
      submitButton: submitButton,
      submitButtonOnKeyboard: submitButton,
    );
  }
}
