import 'package:flutter_base/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static final TokenManager _instance = TokenManager._();

  factory TokenManager() {
    return _instance;
  }

  TokenManager._();

  // 返回持久化对象的实例对象
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = '';

  Future<void> init() async {
    _token = (await _getInstance()).getString(GlobalConstants.TOKEN_KEY) ?? "";
  }

  Future<void> setToken(String val) async {
    _token = val;
    (await _getInstance()).setString(GlobalConstants.TOKEN_KEY, val);
  }

  String getToken() => _token;

  Future<void> removeToken() async {
    (await _getInstance()).remove(GlobalConstants.TOKEN_KEY);
    _token = "";
  }
}

final tokenManager = TokenManager();
