import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactsService {
  Future<List<Contact>> getAllContacts() async {
    try {
      if (await FlutterContacts.requestPermission()) {
        return await FlutterContacts.getContacts();
      }
    } catch (error, stck) {
      debugPrint(error.toString());
      debugPrint(stck.toString());
    }

    return [];
  }

  Future<Map<String, List<Contact>>> getAllContactsGroupByFirstCharacter() async {
    final resultMap = <String, List<Contact>>{};

    try {
      final allContacts = await getAllContacts();

      for (var contact in allContacts) {
        final key = (contact.displayName.isNotEmpty ? contact.displayName[0] : '.').toUpperCase();
        resultMap.putIfAbsent(key, () => [contact]).add(contact);
      }
    } catch (error, stck) {
      debugPrint(error.toString());
      debugPrint(stck.toString());
    }

    return resultMap;
  }
}
