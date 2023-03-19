
import 'package:danvery/routes/app_routes.dart';
import 'package:danvery/ui/pages/auth/login_page/controller/login_page_controller.dart';
import 'package:danvery/ui/widgets/app_bar/transparent_app_bar.dart';
import 'package:danvery/ui/widgets/modern/modern_form_button.dart';
import 'package:danvery/utils/theme/app_text_theme.dart';
import 'package:danvery/utils/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/modern/modern_form_field.dart';


class LoginPage extends GetView<LoginPageController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        appBar: TransparentAppBar(
          title: "로그인",
          isDarkMode: Get.isDarkMode,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 16),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ModernFormField(
                          textController: controller.loginService.idController,
                          hint: '학번(ID)을 입력하세요',
                          title: "학번",
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: ModernFormField(
                          textController: controller.loginService.passwordController,
                          hint: "비밀번호를 입력하세요",
                          title: "비밀번호",
                          isPassword: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  ModernFormButton(
                      text: "로그인",
                      onPressed: () {
                        controller.loginService
                            .login('12345678',
                                '121212') //new: '12345678', '121212'
                            .then((value) {
                          if (value) {
                            Get.offAndToNamed(Routes.main);
                          } else {
                            Get.snackbar(
                                "Error", "로그인 중 오류가 발생했습니다.",
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Palette.white,
                                backgroundColor: Palette.lightBlack,
                            );
                            //여기서 로그인 오류 처리
                          }
                        });
                      }),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "비밀번호 찾기",
                          style: tinyStyle.copyWith(color: Palette.grey),
                        ),
                      ),
                      const Text(
                        "|",
                        style: tinyStyle,
                      ),
                      TextButton(
                          onPressed: () {
                          },
                          child: Text("아이디 찾기",
                              style: tinyStyle.copyWith(color: Palette.grey))),
                      const Text(
                        "|",
                        style: tinyStyle,
                      ),
                      TextButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            Get.toNamed(Routes.register);
                          },
                          child: const Text(
                            "회원가입",
                            style: tinyStyle,
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
