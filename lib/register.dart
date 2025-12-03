import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _pressed = false;
  final String _registerUrl = 'http://127.0.0.1/flutter_api/insert_users.php';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password required')),
      );
      return;
    }

    setState(() {
      _loading = true;
      _pressed = true;
    });

    try {
      final uri = Uri.parse(_registerUrl);
      final resp = await http.post(
        uri,
        body: {'name': name, 'email': email, 'password': password},
      );

      if (resp.statusCode == 200) {
        final data = json.decode(resp.body);
        if (data['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Registered')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'] ?? 'Registration failed')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${resp.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Network error: $e')));
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
          _pressed = true;
        });
      }
    }
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal.shade600,
              padding: const EdgeInsets.all(16.0),
            ),
            onPressed: (_loading || _pressed) ? null : _register,
            child: Text(
              'Register',
              style: TextStyle(
                color: Colors.white,
                fontSize: adaptiveFontSize(context, 15),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: FrostedCard(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Create your account',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: adaptiveFontSize(context, 30),
                    color: Colors.teal.shade900,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 6),
                Text(
                  'Please fill in your details below to get started',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: adaptiveFontSize(context, 18),
                    color: Colors.teal.shade800,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    prefixIcon: Icon(Icons.account_circle, color: Colors.teal),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.teal),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 28),
                _buildActionButtons(),
                const SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontSize: adaptiveFontSize(context, 14),
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(width: 6),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: adaptiveFontSize(context, 14),
                            color: Colors.teal.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
