import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final TextEditingController resetPasswordEmail = TextEditingController();

  void resetPassword() async{

    final email = resetPasswordEmail.text.trim();

    if(email.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter your email'))
      );
      return;
    }

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent'))
      );

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Reset Password', style: TextStyle(fontSize: 32)),
              SizedBox(height: 40),
              TextField(
                controller: resetPasswordEmail,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: resetPassword,
                  child: Text('Send Reset Link')
              )
            ],
          ),
        )
      )
    );
  }
}
