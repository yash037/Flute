import 'package:flute/contants/routes.dart';
import 'package:flute/services/auth/auth_exceptions.dart';
import 'package:flute/services/auth/auth_service.dart';
import 'package:flute/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
} 


class _RegisterViewState extends State<RegisterView> {

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
      appBar: AppBar(title: const Text('Register'),
      ),
      body: Column(
                    children: [
                      TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email here',
                        ),
                      ),
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                          hintText: 'Enter your password here',
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try{

                            await AuthService.firebase().createUser(
                              email: email, 
                              password: password,
                            );

                              await AuthService.firebase().sendEmailVerification();
                              Navigator.of(context).pushNamed(verifyEmailRoute);                        
                          }on WeakPasswordAuthExceptions{
                            await showErrorDialog(
                                context, 
                                'Use Strong Password'
                              );
                          } on InvalidEmailAuthExceptions{
                            await showErrorDialog(
                                context, 
                                'This is an invalid email address'
                              );
                          } on EmailALreadyInUseAuthExceptions{
                            await showErrorDialog(
                                context, 
                                'Email is already in use.'
                              );
                          } on GenericAuthExceptions{
                            await showErrorDialog(
                              context, 
                              'Failed to register',
                              );
                          }
    
                        }, 
                        child: const Text('Register'), 
                        ),
                      TextButton(onPressed: () {
                         Navigator.of(context).pushNamedAndRemoveUntil(
                          loginRoute, 
                            (route) => false,
                            );
                      }, child: const Text('Already Registered? Login Here!',
                    ),
                )
            ],
          ),
    );
  }
}  