import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_exceptions.dart';
import 'package:notes/services/auth/auth_service.dart';
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
                  await  AuthService.firebase().logIn(
                    email: email,
                    password: password
                     );
                   final user = AuthService.firebase().currentUser;
                   if(user?.isEmailVerified ?? false){
                    if (context.mounted) {Navigator.of(context)
                   .pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                     );} 
                   }
                   else{
                    if (context.mounted) {Navigator.of(context)
                   .pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                     );} 
                   }
                   
                 } on UserNotFoundAuthException{
                  if (context.mounted){
                      await showErrorDialog(
                      context,
                      'User not found',);
                    }
                 } on WrongPasswordAuthException {
                  if (context.mounted){
                      await showErrorDialog(
                      context,
                      'Wrong password',);
                    }
                 }
                 on GenericAuthException{
                  if (context.mounted){
                      await showErrorDialog(
                      context,
                      'Authentication error',);
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

