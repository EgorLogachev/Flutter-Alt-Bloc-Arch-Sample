import 'package:archsampleapp/data/api/contacts_api.dart';
import 'package:archsampleapp/data/model/contact.dart';

abstract class ContactsRepository {

  factory ContactsRepository(ContactsApi _api) = _ContactsRepositoryImpl;

  Future<List<Contact>> fetchContacts();

  Future<String> fetchDetails(Contact contact);
}


class _ContactsRepositoryImpl implements ContactsRepository {

  _ContactsRepositoryImpl(this._api);

  final ContactsApi _api;

  Future<List<Contact>> fetchContacts() async => _api.fetchContacts();

  @override
  Future<String> fetchDetails(Contact contact) => _api.fetchDetails(contact);
}
