import 'package:app_sqlite/provider/local_database_provider.dart';
import 'package:app_sqlite/services/sqlite_services.dart';
import 'package:flutter/material.dart';
import 'package:app_sqlite/screen/profiles_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final sqliteServices = SqliteServices();
  runApp(
    MultiProvider(
      providers: [
        Provider.value(value: sqliteServices),
        ChangeNotifierProvider(
          create: (_) => LocalDatabaseProvider(sqliteServices),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ProfilesScreen(),
    );
  }
}
