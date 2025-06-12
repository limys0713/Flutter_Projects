import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalproject_coursework/language_mapping.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final TextEditingController resetPasswordEmailController = TextEditingController();

  @override
  void dispose(){
    resetPasswordEmailController.dispose();
    super.dispose();
  }

  void resetPassword() async{

    final email = resetPasswordEmailController.text.trim();

    if(email.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(textLanguage[globalLanguage.value]!['enterEmail']!))
      );
      return;
    }

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      if(!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(textLanguage[globalLanguage.value]!['resetSent']!))
      );

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${textLanguage[globalLanguage.value]!['resetError']!}: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globalLanguage,
      builder: (context, selectedLanguage, _){
        return Scaffold(
            appBar: AppBar( // To let the return arrow exists
              //title: Text('Reset Password'),
              backgroundColor: Colors.blue[50],
              actions: [
                PopupMenuButton<String>(
                    icon: const Icon(Icons.language),
                    onSelected: (String language){
                      globalLanguage.value = language;
                    },   // widget.function >> Because the var is at widget class
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(value: 'zh', child: Text('繁體中文')),
                      PopupMenuItem(value: 'en', child: Text('English'))
                    ]
                )
              ],
            ),
            backgroundColor: Colors.blue[50],
            body: Padding(
              padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(textLanguage[selectedLanguage]!['resetPassword']!, style: TextStyle(fontSize: 32)),
                  SizedBox(height: 35),
                  TextField(
                    controller: resetPasswordEmailController,
                    decoration: InputDecoration(
                        labelText: textLanguage[selectedLanguage]!['enterEmail']!,
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: resetPassword,
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                      child: Text(textLanguage[selectedLanguage]!['sendResetLink']!)
                  )
                ],
              ),
            )
        );
      }
    );
  }
}
