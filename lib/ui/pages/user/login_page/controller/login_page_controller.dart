import 'package:danvery/service/login/login_service.dart';
import 'package:get/get.dart';

class LoginPageController extends GetxController{

  final LoginService loginService = Get.find<LoginService>();

  final RxString id = "".obs;
  final RxString password = "".obs;

  final RxBool isPasswordVisible = false.obs;

}
