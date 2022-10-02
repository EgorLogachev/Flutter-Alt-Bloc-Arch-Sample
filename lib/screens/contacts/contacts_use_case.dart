import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/repositories/contacts_repository.dart';
import 'package:archsampleapp/screens/connection/connection_use_case.dart';

class ContactsUseCase implements ConnectionUseCase {

  final ConnectionUseCase _connectionUseCase;
  final ContactsRepository _repository;

  ContactsUseCase(this._connectionUseCase, this._repository);

  @override
  Future<int> fetchSession() => _connectionUseCase.fetchSession();

  Future<List<Contact>> fetchContacts() => _repository.fetchContacts();
}
