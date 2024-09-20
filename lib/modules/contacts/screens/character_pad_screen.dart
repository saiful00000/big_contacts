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

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // Number of columns
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: characters.length,
                itemBuilder: (context, index) {
                  return TextButton(
                    style: ButtonStyle(
                      side: WidgetStateProperty.all(
                        const BorderSide(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                      ),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      characters[index],
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                },
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
