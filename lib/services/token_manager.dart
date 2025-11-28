import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String accessTokenKey = "access_token";

class TokenManager {
  static final TokenManager _instance = TokenManager._internal();

  late FlutterSecureStorage _secureStorage;

  TokenManager._internal() {
    _secureStorage = const FlutterSecureStorage();
  }

  static TokenManager get instance {
    return _instance;
  }

  Future<String?>  getAccessToken() async => await _secureStorage.read(key: accessTokenKey);

  Future<void> setTokens(String accessToken) async => await _secureStorage.write(key: accessTokenKey, value: accessToken);
}