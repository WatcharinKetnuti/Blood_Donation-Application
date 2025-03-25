import 'package:get_storage/get_storage.dart';

mixin CacheManager {
  final box = GetStorage();


  Future<bool> saveToken(String? token) async {
    await box.write(CacheManagerKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    return box.read(CacheManagerKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    await box.remove(CacheManagerKey.TOKEN.toString());
  }

}

enum CacheManagerKey { TOKEN }
