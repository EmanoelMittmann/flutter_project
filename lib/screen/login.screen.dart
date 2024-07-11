import 'dart:async';

import 'package:apiflutter/screen/register.screen.dart';
import 'package:apiflutter/services/firebase/auth_services.dart';
import 'package:apiflutter/utils/results.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import 'charecter-list.screen.dart';

class Login extends StatelessWidget {
  final TextEditingController emailState = TextEditingController();
  final TextEditingController passState = TextEditingController();
  final authService = AuthServices();
  final controller = StreamController();

  Login({super.key});

  signIn() async {
    final toDomain =
        UserModel(email: emailState.text, password: passState.text);

    await authService.signIn(toDomain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: authService.resultsLogin,
          builder: (context, snapshot) {
            if (snapshot.error is ErrorResults) {
              return const Text(
                'Invalid inputs',
                style: TextStyle(color: Colors.red),
              );
            }

            if (snapshot.data is LoadingResults) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data is SucessResults) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CharacterListScreen()));
              });
            }

            return Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[Color(0xFF0029Ff), Color(0xFF0099FF)])),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 280),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Raleway'),
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'E-mail',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      controller: emailState,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1.5)),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Colors.white, fontSize: 20.0)),
                      controller: passState,
                      obscureText: true,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          signIn();
                        },
                        child: const Text('Logar')),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: const Text(
                        'Inscrever-se',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
