import 'dart:async';

import 'package:apiflutter/models/user_model.dart';
import 'package:apiflutter/screen/charecter-list.screen.dart';
import 'package:apiflutter/screen/login.screen.dart';
import 'package:apiflutter/services/firebase/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class InitializeApp extends StatelessWidget {
  final AuthServices _auth = AuthServices();

  InitializeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
        stream: _auth.user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data!.email.isNotEmpty) {
            return CharacterListScreen();
          }

          return Text('Campos invalidos');
        });
  }
}
