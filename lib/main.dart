import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';
import 'package:notes/views/login_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ));
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Login'),
        ),
      body: FutureBuilder( 
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
              ),
        builder: (context, snapshot) {
          switch(snapshot.connectionState){
            case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // if(user?.emailVerified ?? false){
            //   return const Text('Done');
            // }
            // else{
            //   return const VeryfyEmailView();
            // }
              return const LoginView();
            default:
              return const Text('Loading...');
          }
          
        }, 
      ),
    );
  }
}

class VeryfyEmailView extends StatefulWidget {
  const VeryfyEmailView({super.key});

  @override
  State<VeryfyEmailView> createState() => _VeryfyEmailViewState();
}

class _VeryfyEmailViewState extends State<VeryfyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
          const Text("Please veryfy your email address"),
          TextButton(onPressed: () async{
             final user = FirebaseAuth.instance.currentUser;
             await user?.sendEmailVerification();
          }, child: const Text('Send email verification'))
        ],);
  }
}


