import 'dart:async';

import 'package:apiflutter/models/user_model.dart';
import 'package:apiflutter/utils/results.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserModel> get user {
    return _auth.authStateChanges().map((user) {
      return UserModel(
          email: user?.email ?? '', password: user?.refreshToken ?? '');
    });
  }
  
  final StreamController<Results> _resultsLogin = StreamController<Results>.broadcast();
  
  Stream<Results> get resultsLogin => _resultsLogin.stream;

  signIn(UserModel user) async {
    try{
      await _auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      _resultsLogin.add(SucessResults());
    }catch(e){
      debugPrint(e.toString());
      _resultsLogin.add(ErrorResults());
      throw Error();
    }
  }

  signUp(UserModel user) async {
    try{
      debugPrint(user.email);
      debugPrint(user.password);
      await _auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      _resultsLogin.add(SucessResults());
    }catch(e){
      debugPrint(e.toString());
      _resultsLogin.add(ErrorResults());
    }
  }

  signOut() async {
    await _auth.signOut();
  }
}
