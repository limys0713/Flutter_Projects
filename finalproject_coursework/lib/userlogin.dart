import 'package:flutter/material.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Login'),
      ),
      // User Login UI
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Tells the Column to only occupy as much vertical space as its children need
            children: [
              Text('User Login', style: TextStyle(fontSize: 32)),
              SizedBox(height: 20),  // Adds vertical spacing below the title
              /* Email Input */
              TextField(  // Widget class that used to get input
                //controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 12),
              /* Password Input */
              TextField(
                //controller: ,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder()
                ),
              ),
              SizedBox(height: 15),
              /* Login Button */
              ElevatedButton( // A raised button with background colour and elevation
                  onPressed: () {},
                  child: Text('Login')
              )
            ],
          ),
        ),
      ),
    );
  }
}
