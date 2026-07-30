import 'package:flutter_base/viewmodels/user.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  // 真正的user放在了user.value里
  var user = UserInfo.fromJSON({}).obs;
  void updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
