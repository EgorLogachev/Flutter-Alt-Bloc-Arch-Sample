import 'package:archsampleapp/data/api/contacts_api.dart';
import 'package:archsampleapp/data/model/contact.dart';

class ContactsRepository {

  ContactsRepository(this._api);

  final ContactsApi _api;

  Future<List<Contact>> fetchContacts() async => _api.fetchContacts();
}