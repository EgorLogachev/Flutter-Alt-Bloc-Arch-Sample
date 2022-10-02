import 'package:archsampleapp/data/api/auth_api.dart';
import 'package:archsampleapp/data/api/connection_api.dart';
import 'package:archsampleapp/data/api/contacts_api.dart';
import 'package:archsampleapp/data/network/network_service.dart';
import 'package:archsampleapp/data/repositories/auth_repository.dart';
import 'package:archsampleapp/data/repositories/connection_repository.dart';
import 'package:archsampleapp/data/repositories/contacts_repository.dart';
import 'package:archsampleapp/di/dependency_manager.dart';
import 'package:archsampleapp/screens/auth/auth_use_case.dart';
import 'package:archsampleapp/screens/connection/connection_use_case.dart';
import 'package:archsampleapp/screens/contact_details/contacts_details_use_case.dart';
import 'package:archsampleapp/screens/contacts/contacts_use_case.dart';

class Dependencies {
  final _dr = DependenciesRegistrar()
    ..register((_) => NetworkService(baseUrl: 'http://some_base_url'))
    ..register((dp) => AuthApi(dp.obtain<NetworkService>()))
    ..register((dp) => ConnectionApi(dp.obtain<NetworkService>()))
    ..register((dp) => ContactsApi(dp.obtain<NetworkService>()))
    ..register((dp) => AuthRepository(dp.obtain<AuthApi>()))
    ..register((dp) => ConnectionRepository(dp.obtain<ConnectionApi>()))
    ..register((dp) => ContactsRepository(dp.obtain<ContactsApi>()))
    ..register((dp) => SignInUseCase(dp.obtain<AuthRepository>()))
    ..register((dp) => ConnectionUseCase(dp.obtain<ConnectionRepository>()))
    ..register((dp) => ContactsUseCase(dp.obtain<ConnectionUseCase>(), dp.obtain<ContactsRepository>()))
    ..register((dp) => ContactDetailsUseCase(dp.obtain<ConnectionUseCase>(), dp.obtain<ContactsRepository>()));

  DependenciesProvider get provider => _dr.provider;

  void dispose() => _dr.dispose();
}

extension AppDependencyProvider on DependenciesProvider {

  SignInUseCase get signInUseCase => obtain<SignInUseCase>();

  ContactsUseCase get contactsUseCase => obtain<ContactsUseCase>();

  ContactDetailsUseCase get contactDetailsUseCase => obtain<ContactDetailsUseCase>();
}
