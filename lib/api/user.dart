import 'package:flutter_base/constants/index.dart';
import 'package:flutter_base/utils/DioRequest.dart';
import 'package:flutter_base/viewmodels/user.dart';

Future<UserInfo> loginAPI(Map<String, dynamic> params) async {
  DioRequest dioRequest = DioRequest();
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstants.LOGIN, params: params),
  );
}

Future<UserInfo> getUserInfoAPI() async {
  DioRequest dioRequest = DioRequest();
  return UserInfo.fromJSON(await dioRequest.get(HttpConstants.USER_PROFILE));
}
