import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  SignInScreen({super.key});
  
  @override
  Widget build(BuildContext context) {

    Future<void> _login() async {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        // Login bem-sucedido
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bem-vindo, ${userCredential.user?.email}!')),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } catch (e) {
        // Erro no login
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${e.toString()}')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( 
          key: _formKey, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                validator: (value) { // Add email validation
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // You can add more sophisticated email validation here
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Sena'),
                obscureText: true, // Hide the password
                validator: (value) { // Add password validation
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  // You can add more sophisticated password validation here
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              TextButton(
                onPressed: () {}, 
                child: const Text('Não possui conta? Clique aqui')
              ),
              const SizedBox(height: 8.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // _googleSignIn(context);
                    if (_formKey.currentState!.validate()) { // Validate the form
                      // Process sign-in logic here
                      String email = _emailController.text;
                      String password = _passwordController.text;
                
                      // TODO: Implement actual authentication logic
                      print('Email: $email, Password: $password');
                      _login();
                
                
                      // Example navigation after successful sign-in
                      // Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  child: const Text('ENTRAR'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
