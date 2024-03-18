import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:notes/constants/routes.dart';
import 'package:notes/utilities/show_error_dialog.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
   late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login'),),
      body: Column(
            children: [
              TextField(
                controller: _email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress, //małpa w klawiaturze
                decoration: const InputDecoration(
                  hintText: 'Enter your email here'
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,//kropeczki
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter your password here'
                ),
              ),
              TextButton(
                onPressed: () async {//async do rejestracji
                final email = _email.text;
                final password = _password.text;
                 try{
                  await FirebaseAuth.instance.signInWithEmailAndPassword(//await
                  email: email,
                   password: password,
                   );
                   if (context.mounted) {Navigator.of(context)
                   .pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                     );} 
                 } on FirebaseAuthException catch(e){
                  if (e.code == 'invalid-credential'){
                    if (context.mounted){
                      await showErrorDialog(
                      context,
                      'Incorrect data was provided',);
                    }
                  }
                  else{
                     if (context.mounted){
                      await showErrorDialog(
                      context,
                      'Error: ${e.code}',);
                    }
                  }
                  devtools.log(e.code.toString());   // typ wyjątku
                 } catch(e){
                  if (context.mounted){
                      await showErrorDialog(
                      context,
                      'Error: ${e.toString()}',);
                    }
                 }
             
              },child: const Text('Login'),),
              TextButton(
                onPressed: (){
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    registerRoute,
                     (route) => false);
                },
                child: const Text('Register here'))
            ],
          ),
    );
  }
}

