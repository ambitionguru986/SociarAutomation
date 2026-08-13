import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

abstract class TokenLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
}

const cachedTokenKey = 'auth_token';

@LazySingleton(as: TokenLocalDataSource)
class TokenLocalDataSourceImpl implements TokenLocalDataSource {
  final FlutterSecureStorage _storage;

  TokenLocalDataSourceImpl()
      : _storage = const FlutterSecureStorage();

  @override
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: cachedTokenKey);
    } catch (e) {
      throw CacheException('Failed to read token');
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: cachedTokenKey, value: token);
    } catch (e) {
      throw CacheException('Failed to save token');
    }
  }
}
