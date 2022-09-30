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

class ContactsApi {

  ContactsApi(this._networkService);

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
}