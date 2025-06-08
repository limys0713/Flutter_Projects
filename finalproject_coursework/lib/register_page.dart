import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _confirmobscurePassword = true;

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
        SnackBar(content: Text('Please fill in all fields'))
      );
      return;
    }

    if(password != confirmPassword){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Passwords do not match'))
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
          SnackBar(content: Text('Registration successful!'))
      );

      // Navigate back to login
      // Go back to the previous screen in the navigation stack
      Navigator.pop(context);

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /* Email Text Field */
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email'
              ),
            ),
            SizedBox(height: 20),
            /* Password Text Field */
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
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
              obscureText: _confirmobscurePassword,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      _confirmobscurePassword = !_confirmobscurePassword; // Toggle
                    });
                  }
                )
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: handleRegister,  // Jump to handleRegister function
                child: Text('Register')
            )
          ],
        ),
      ),
    );
  }
}
