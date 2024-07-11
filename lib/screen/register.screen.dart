import 'package:apiflutter/models/user_model.dart';
import 'package:apiflutter/screen/charecter-list.screen.dart';
import 'package:apiflutter/services/firebase/auth_services.dart';
import 'package:apiflutter/utils/results.dart';
import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  final TextEditingController emailState = TextEditingController();
  final TextEditingController passState = TextEditingController();
  final authService = AuthServices();

  signUp() async {
    final toDomain =
        UserModel(email: emailState.text, password: passState.text);
    authService.signUp(toDomain);
  }

  Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registre-se'),
      ),
      body: StreamBuilder<Object>(
        stream: authService.resultsLogin,
        builder: (context, snapshot) {
          
          if(snapshot.data is SucessResults){
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CharacterListScreen()));
            });
          }

          if(snapshot.data is LoadingResults){
            return const Center(child: CircularProgressIndicator(),);
          }

          if(snapshot.data is ErrorResults){
            return const Text('Invalid inputs');
          }
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: emailState,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  controller: passState,
                ),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    child: const Text('Cadastrar')),
              ],
            ),
          );
        }
      ),
    );
  }
}
