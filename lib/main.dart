import 'package:contacts_x/modules/contacts/screens/character_pad_screen.dart';
import 'package:contacts_x/modules/contacts/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'navigation/app_navigator.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call XL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      navigatorKey: AppNavigator.navKey,
      initialRoute: CharacterPadScreen.routeName,
      onGenerateRoute: AppNavigator.generateRoutes,
      scaffoldMessengerKey: AppNavigator.scaffoldMessengerKey,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: ContactsService().getAllContacts(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final contacts = snapshot.data ?? [];

          return ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(contacts[index].displayName),
              );
            },
          );
        },
      ),
    );
  }
}
