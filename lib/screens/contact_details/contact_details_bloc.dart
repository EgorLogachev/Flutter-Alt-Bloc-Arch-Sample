import 'package:archsampleapp/common/base_bloc.dart';
import 'package:archsampleapp/data/model/contact.dart';
import 'package:archsampleapp/screens/connection/connection_bloc.dart';
import 'package:archsampleapp/screens/contact_details/contacts_details_use_case.dart';

class ContactDetailsBloc extends BaseBloc {

  final ContactDetailsUseCase _useCase;
  final Contact _contact;
  final ConnectionBloc _connectionBloc;

  ContactDetailsBloc(this._useCase, this._contact)
      : _connectionBloc = ConnectionBloc(_useCase) {
    registerState<String>(initialState: '');
    addNavigationSource(_connectionBloc.navigationStream!);
    _loadDescription();
  }

  Future startCall() => _connectionBloc.startCall(_contact);

  Future startChat() => _connectionBloc.startChat(_contact);

  void _loadDescription() {
    addStateSource(_useCase.fetchDetails(_contact));
  }
}
