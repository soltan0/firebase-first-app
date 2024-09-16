import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubits/users/users_cubit.dart';
import 'data/services/users_service.dart';
import 'ui/screens/users/users_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBj7mKXOz52rMewHXbQArx8Yhlzo-P02jM',
      appId: '1:545816589659:android:2ebccaa8111f1c5fa7567e',
      messagingSenderId: '545816589659',
      projectId: 'fir-first-app-7335d',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => UsersCubit(UsersService())..getUsers(),
        child: const UsersScreen(),
      ),
    );
  }
}
