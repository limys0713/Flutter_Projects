import 'package:finalproject_coursework/change_password.dart';
import 'package:finalproject_coursework/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finalproject_coursework/home_page.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  // A Dart object that controls a TextField, letting you read or set its text
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  /* Dispose objects that managing system memory after the execution ends */
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleLogin() async{
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if(email.isEmpty || password.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter bothe email and password')),
      );
      return;
    }

    try{  // Login in successful >> continue
      // FirebaseAuth object used to log in users
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      // Stop if widget is no longer active
      // Because this BuildContext may no longer be valid after the await. The widget could be disposed.
      // Exists in every State class >> It’s true if the widget is still in the tree >> It’s false if it was disposed (removed)
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful!'))
      );

      // TODO: Navigate to another screen here
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage())
      );

    } catch(e){ // Fail to login
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed!: ${e.toString()}'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('User Login'),
      // ),
      backgroundColor: Colors.blue[50],
      // User Login UI
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 120, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Tells the Column to only occupy as much vertical space as its children need
          children: [
            Icon(Icons.local_hospital_rounded, size: 100, color: Colors.red[600]),
            // Image.asset(
            //   'assets/images/healthcare_image.png',
            //   height: 120,
            // ),
            Text(
              'Healthcare Visit Helper APP',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
                letterSpacing: 1.0
              ),
            ),
            SizedBox(height: 45),
            const Text('User Login', style: TextStyle(fontSize: 32)),
            SizedBox(height: 20),  // Adds vertical spacing below the title
            /* Email Input */
            TextField(  // Widget class that used to get input
              controller: emailController,  // TextEditingController variable
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white
              ),
            ),
            SizedBox(height: 12),
            /* Password Input */
            TextField(
              controller: passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(Icons.remove_red_eye)
                )
              ),
            ),
            SizedBox(height: 6),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePassword()) // Takes context as input and returns the screen/widget you want to display
                  );
                },
                child: const Text('Forgot your password? Reset here')
            ),
            SizedBox(height: 15),
            /* Login Button */
            ElevatedButton( // A raised button with background colour and elevation
              onPressed: handleLogin, // Passing a function >> run when the button  is pressed // handleLogin(): Calling the function and trying to give its result(void) to onPressed
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: const Text('Login'),
            ),
            SizedBox(height: 65),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()) // Takes context as input and returns the screen/widget you want to display
                  );
                },
                child: const Text('Don\'t have an account? Register here')
            ),
          ],
        ),
      ),
    );
  }
}
