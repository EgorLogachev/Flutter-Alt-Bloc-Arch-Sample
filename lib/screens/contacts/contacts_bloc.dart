import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/data/repositories/contacts_repository.dart';

import '../../common/base_bloc.dart';
import '../connection_bloc.dart';
import 'contacts_router.dart';

class ContactsBloc extends BaseBloc implements ConnectionBloc {
  ContactsBloc(this._repository, this._connectionBloc) {
    registerState<List<Contact>>(initialState: <Contact>[]);
    addNavigationSource(_connectionBloc.navigationStream);
    getContacts();
  }

  final ContactsRepository _repository;

  final ConnectionBloc _connectionBloc;

  Future<void> getContacts() async {
    showProgress();
    addStateSource<List<Contact>>(_repository.fetchContacts(),
        onDone: () => hideProgress(),
        onError: (e) => handleError(e));
  }

  void showDetails(Contact contact) {
    addNavigation(routeName: ContactsRouter.contactDetailsRoute, arguments: contact);
  }

  @override
  Future startCall(Contact contact) => _connectionBloc.startCall(contact);

  @override
  Future startChat(Contact contact) => _connectionBloc.startChat(contact);
}
