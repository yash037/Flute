import 'package:flute/contants/routes.dart';
import 'package:flute/services/auth/auth_service.dart';
import 'package:flute/views/login_view.dart';
import 'package:flute/views/notes_view.dart';
import 'package:flute/views/register_view.dart';
import 'package:flute/views/verify_email.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
      ),
      home: const HomePage(),
      routes: {
        loginRoute : (context) => const LoginView(),
        registerRoute : (context) => const RegisterView(),
        notesRoute : (context) => const NotesView(),
        verifyEmailRoute : (context) => const VerifyEmailView(),
      },
    ),
  );
}
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: AuthService.firebase().initialize(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState){
              case ConnectionState.done :
                
                  final user = AuthService.firebase().currentUser;
                  if(user != null){
                    if(user.isEmailVerified){
                      return const NotesView();
                    }
                    else{
                      return const VerifyEmailView();
                    }
                  }else{
                    return const LoginView();                    
                  }
                default :
                return const CircularProgressIndicator();
            }
          },
     );
  }
}









 
