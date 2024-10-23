import 'package:flutter/material.dart';
import 'package:my_cool_game/my_cool_game.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ToastificationWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'My Cool Game',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const MyCoolGame(),
        ),
      );
}
