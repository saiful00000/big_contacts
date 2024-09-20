import 'package:contacts_x/modules/contacts/services/contacts_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final contactsServiceProvider = Provider.autoDispose((ref) => ContactsService());

final contactListProvider = FutureProvider.autoDispose((ref) async {
  return await ref.read(contactsServiceProvider).getAllContacts();
});

final allContactsMapProvider = FutureProvider.autoDispose((ref) async {
  return await ref.read(contactsServiceProvider).getAllContactsGroupByFirstCharacter();
});

final selectedCharacterProvider = StateProvider.autoDispose((ref) => 'All');