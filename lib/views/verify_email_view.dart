import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/services/auth/auth_service.dart';

class VeryfyEmailView extends StatefulWidget {
  const VeryfyEmailView({super.key});

  @override
  State<VeryfyEmailView> createState() => _VeryfyEmailViewState();
}

class _VeryfyEmailViewState extends State<VeryfyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: Column(children: [
            const Text("We' ve send you an email verification. Please open it to verify your account"),
            const Text("If you haven't received a verification email yet, pless the button below"),
            TextButton(onPressed: () async{
               AuthService.firebase().sendEmailVerification();
            }, child: const Text('Send email verification'),
            ),
            TextButton(onPressed: () async{
              await AuthService.firebase().logOut();
              if (context.mounted) {Navigator.of(context)
                   .pushNamedAndRemoveUntil(
                    registerRoute,
                    (route) => false,
                     );} 
            }, child: const Text("Restart"))
          ],),
    );
  }
}