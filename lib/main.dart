import 'package:flutter/material.dart';
import 'register.dart';

double adaptiveFontSize(BuildContext context, double baseSize) {
  final screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 400) {
    return baseSize * 0.8;
  } else if (screenWidth > 700) {
    return baseSize * 1.2;
  } else {
    return baseSize;
  }
}

class FrostedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const FrostedCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final cardWidth = screenWidth > 700 ? 600.0 : screenWidth * 0.8;

    final cardPadding =
        padding ?? EdgeInsets.all(screenWidth < 400 ? 16.0 : 32.0);

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: cardPadding,
      child: child,
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome back!',
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
                  'Let\'s get you signed in',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: adaptiveFontSize(context, 18),
                    color: Colors.teal.shade800,
                  ),
                ),
                SizedBox(height: 26),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.teal),
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline, color: Colors.teal),
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // handle login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: adaptiveFontSize(context, 16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontSize: adaptiveFontSize(context, 14),
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(width: 6),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
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
