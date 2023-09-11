import 'package:danvery/domain/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../modules/orb/components/components.dart';

class VerifySMStoResetPasswordScreen extends ConsumerWidget {
  final TextEditingController _verifySMSController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  VerifySMStoResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return OrbScaffold(
      pageHelpText: '문자로 받은\n인증번호 6자리를 입력해주세요',
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            OrbTextFormField(
              controller: _verifySMSController,
              labelText: '인증번호(6자리 숫자)',
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.phone,
              maxLength: 6,
              readOnly: false,
              autofocus: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '인증번호를 입력해주세요';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      submitButton: OrbButton(
        onPressed: () async {
          if (!_formKey.currentState!.validate()) {
            return;
          }
          await ref
              .read(userProvider.notifier)
              .verifySMStoResetPassword(_verifySMSController.text);
        },
        child: const Text('확인'),
      ),
    );
  }
}
