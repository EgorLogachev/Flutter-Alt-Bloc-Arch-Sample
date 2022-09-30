import 'package:archsampleapp/data/api/auth_api.dart';
import 'package:archsampleapp/data/api/connection_api.dart';
import 'package:archsampleapp/data/api/contacts_api.dart';
import 'package:archsampleapp/data/network/network_service.dart';
import 'package:archsampleapp/data/repositories/auth_repository.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:archsampleapp/data/repositories/contacts_repository.dart';

mixin Dependencies {

  NetworkService? _networkService;
  AuthApi? _authApi;
  ConnectionApi? _connectionApi;
  ContactsApi? _contactsApi;
  AuthRepository? _authRepository;
  ConnectionRepository? _connectionRepository;
  ContactsRepository? _contactsRepository;

  NetworkService get networkService => _networkService ??= NetworkService(baseUrl: 'http://some_base_url');

  AuthApi get authApi => _authApi ??= AuthApi(networkService);

  ConnectionApi get connectionApi => _connectionApi ??= ConnectionApi(networkService);

  ContactsApi get contactsApi => _contactsApi ??= ContactsApi(networkService);

  AuthRepository get authRepository => _authRepository ??= AuthRepository(authApi);

  ConnectionRepository get connectionRepository => _connectionRepository ??= ConnectionRepository(connectionApi);

  ContactsRepository get contactsRepository => _contactsRepository ??= ContactsRepository(contactsApi);


}
