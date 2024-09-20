import 'package:contacts_x/modules/contacts/providers/contacts_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharacterPadScreen extends ConsumerStatefulWidget {
  static const routeName = 'CharacterPadScreen';

  const CharacterPadScreen({super.key});

  @override
  ConsumerState createState() => _CharacterPadScreenState();
}

class _CharacterPadScreenState extends ConsumerState<CharacterPadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final asyncContactsMap = ref.watch(allContactsMapProvider);

          return asyncContactsMap.when(
            data: (contactsMap) {
              final characters = contactsMap.keys.toList();

              return Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Consumer(builder: (context, ref, _) {
                      final selectedCharacter = ref.watch(selectedCharacterProvider);
                      final contacts = contactsMap[selectedCharacter] ?? [];

                      return ListView.builder(
                        itemCount: contacts.length,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 10,
                        ),
                        itemBuilder: (context, index) {
                          final contact = contacts[index];

                          return Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      contact.displayName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: contact.phones.length,
                                      itemBuilder: (context, phoneIndex) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              contact.phones[phoneIndex].number,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Visibility(
                                              visible: phoneIndex != (contact.phones.length - 1),
                                              child: const SizedBox(height: 4),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.green.shade400,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 16,
                                            ),
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.call,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'Call',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.deepOrange.shade400,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 10,
                                              horizontal: 16,
                                            ),
                                            child: const Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.email,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'SMS',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                height: .5,
                                color: Colors.blueGrey.withOpacity(.5),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: double.infinity,
                      child: ListView.builder(
                        itemCount: characters.length,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          bottom: 300,
                        ),
                        itemBuilder: (context, index) {
                          return Consumer(builder: (context, ref, _) {
                            final selectedCharacter = ref.watch(selectedCharacterProvider);

                            return InkWell(
                              onTap: () {
                                ref.read(selectedCharacterProvider.notifier).state =
                                    characters[index];
                              },
                              child: Container(
                                height: 70,
                                width: 70,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: selectedCharacter == characters[index]
                                      ? Colors.white
                                      : Colors.blueGrey.shade100,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  characters[index],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stck) => const SizedBox(),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
