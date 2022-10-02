import 'package:archsampleapp/data/mock_data_generator.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/network/network_errors.dart';
import 'package:archsampleapp/data/network/network_service.dart';

const names = [
  'Olivia',
  'Ava',
  'Isabella',
  'Sophia',
  'Charlotte',
  'Mia',
  'Amelia',
  'Harper',
  'Evelyn',
  'Abigail',
  'Emily',
  'Elizabeth',
  'Mila',
  'Ella',
  'Avery',
  'Sofia',
  'Camila',
  'Aria',
  'Scarlett',
  'Victoria',
  'Madison',
  'Luna',
  'Grace',
  'Chloe',
  'Penelope',
  'Layla',
  'Riley',
  'Zoey',
  'Nora',
  'Lily',
  'Eleanor',
  'Hannah',
  'Lillian',
  'Addison',
  'Aubrey',
  'Ellie',
  'Stella',
  'Natalie',
  'Zoe'
];

abstract class ContactsApi {

  factory ContactsApi(NetworkService _networkService) = _MockedContactsApiImpl;

  Future<List<Contact>> fetchContacts();

  Future<String> fetchDetails(Contact contact);
}


class _MockedContactsApiImpl implements ContactsApi {

  _MockedContactsApiImpl(this._networkService);

  final NetworkService _networkService;

  Future<List<Contact>> fetchContacts() {
    final mixedNames = List.of(names);
    mixedNames.shuffle();
    final result = MockDataGenerator([
      Option(List.generate(mixedNames.length, (index) => Contact(mixedNames[index])), weight: 10),
      Option(ConnectionError()),
      Option(UnexpectedError(500, ""))
    ]).next();
    return Future.delayed(Duration(milliseconds: 500), () => result is Error ? throw result : result);
  }

  @override
  Future<String> fetchDetails(Contact contact) async {
    return 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
  }
}