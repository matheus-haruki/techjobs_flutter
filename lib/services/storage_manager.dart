import 'package:TechJobs/models/dados_usuario_model.dart';
import 'package:TechJobs/models/logar_usuario_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

const String accessTokenKey = "access_token"; 
const String userKey = "user_data";

class StorageManager {
  static final StorageManager _instance = StorageManager._internal();

  late FlutterSecureStorage _secureStorage;
  late SharedPreferences _sharedPreferences;

  StorageManager._internal() {
    _secureStorage = const FlutterSecureStorage(); 
  }

  static StorageManager get instance {
    return _instance;
  }

  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> setUserCredentials(LogarUsuarioResponse tokenResponse) async {
    await setAccessToken(tokenResponse.token);

    await saveUser(UserModel(nomeUsuario: tokenResponse.nomeUsuario, email: tokenResponse.email, perfil: tokenResponse.perfil));
  }

  Future<String?> getAccessToken() async => 
      await _secureStorage.read(key: accessTokenKey);

  Future<void> setAccessToken(String token) async => 
      await _secureStorage.write(key: accessTokenKey, value: token);


  Future<void> saveUser(UserModel user) async {
    final userJson = user.toJson();
    
    await _sharedPreferences.setString(userKey, userJson);
  }

  Future<UserModel?> getUser() async {
    final userJson = _sharedPreferences.getString(userKey);
    
    if (userJson == null) return null;

    try {
      final usuarioFrom = UserModel.fromJson(userJson);
      return usuarioFrom;
    } catch (e) {
      await _sharedPreferences.remove(userKey);
      return null;
    }
  }
  
  Future<void> clearAll() async {
    await _secureStorage.delete(key: accessTokenKey);
    
    await _sharedPreferences.remove(userKey);
  }
}