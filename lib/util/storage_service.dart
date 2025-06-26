import 'package:get_storage/get_storage.dart';

class StorageService {
  GetStorage box = GetStorage("box");
  Future<void> initStorage() async {
    await GetStorage.init();
  }

  Future<void> writeData(String key, dynamic value) async {
    await box.write(key, value);
  }

  readData(String key) async {
    return box.read(key);
  }

  Future<void> removeData(String key) async {
    box.remove(key);
  }
}
