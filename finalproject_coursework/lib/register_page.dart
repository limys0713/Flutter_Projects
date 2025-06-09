import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject_coursework/language_mapping.dart';

class RegisterPage extends StatefulWidget {
  final String selectedLanguage;
  final ValueChanged<String> onLanguageChanged;
  const RegisterPage({super.key, required this.selectedLanguage, required this.onLanguageChanged});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _confirmObscurePassword = true;

  // Clear memory
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void handleRegister() async{
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if(email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(textLanguage[widget.selectedLanguage]!['pleaseFillAll']!))
      );
      return;
    }

    if(password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(textLanguage[widget.selectedLanguage]!['passwordNotMatch']!))
      );
      return;
    }

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      // Stop if widget is no longer active
      // Because this BuildContext may no longer be valid after the await. The widget could be disposed.
      // Exists in every State class >> It’s true if the widget is still in the tree >> It’s false if it was disposed (removed)
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(textLanguage[widget.selectedLanguage]!['registerSuccess']!))
      );

      // Navigate back to login
      // Go back to the previous screen in the navigation stack
      Navigator.pop(context);

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${textLanguage[widget.selectedLanguage]!['registerFail']!}: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.language),
            onSelected: widget.onLanguageChanged,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(value: 'en', child: Text('English')), // value is the thing that gets returned when that item is clicked
              PopupMenuItem(value: 'zh', child: Text('中文'))
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
            Text(textLanguage[widget.selectedLanguage]!['registerAccount']!, style: TextStyle(fontSize: 32)),
            SizedBox(height: 35),
            /* Email Text Field */
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: textLanguage[widget.selectedLanguage]!['email']!,
                filled: true,
                fillColor: Colors.white
              ),
            ),
            SizedBox(height: 20),
            /* Password Text Field */
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: textLanguage[widget.selectedLanguage]!['password']!,
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword; // Toggle
                      });
                    },
                    icon: Icon(Icons.remove_red_eye)
                )
              ),
            ),
            SizedBox(height: 20),
            /* Confirm Password Text Field */
            TextField(
              controller: confirmPasswordController,
              obscureText: _confirmObscurePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: textLanguage[widget.selectedLanguage]!['confirmPassword']!,
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      _confirmObscurePassword = !_confirmObscurePassword; // Toggle
                    });
                  }
                )
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: handleRegister,  // Jump to handleRegister function
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                child: Text(textLanguage[widget.selectedLanguage]!['register']!)
            )
          ],
        ),
      ),
    );
  }
}
