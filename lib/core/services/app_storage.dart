import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  final SharedPreferences storage;

  AppStorage({required this.storage});

  Future<void> write(SecureStorageItem item) async {
    final encodedValue = item.value;
    await storage.setString(item.key, encodedValue);
  }

  Future<String?> read(String key) async {
    await storage.reload();
    final encodedValue = await storage.getString(key);
    return encodedValue;
  }

  Future<void> delete(String key) async {
    await storage.remove(key);
  }

  Future<void> deleteAll() async {
    await storage.clear();
  }

  Future<bool> exists(String key) async {
    await storage.reload();
    final result = storage.containsKey(key);
    return result;
  }

  Future<Map<String, dynamic>> readAll() async {
    await storage.reload();
    Set<String> keys = storage.getKeys();
    Map<String, dynamic> data = {};
    for (String key in keys) {
      data[key] = storage.get(key);
    }

    return data;
  }

  Future<bool> containsKey(String key) async {
    await storage.reload();
    final result = storage.containsKey(key);
    return result;
  }
}

class SecureStorageItem {
  SecureStorageItem({required this.key, required this.value});
  final String key;
  final String value;
}
