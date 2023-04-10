import 'package:firebase_auth/firebase_auth.dart';
import 'package:flute/contants/routes.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override 
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email'),
      ),
      body: Column(
        children: [
          const Text("We've sent you an email verification. Please open it to verify account."),
          const Text("If you haven't receivde a verification email yet, press the button below"),
          TextButton(
            onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          }, 
          child: const Text('Send Email verification'),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            }, 
            child: const Text('Restart'),
            ),
        ],
      ),
    );
  }
}