import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screen/landing_screen.dart';
import 'package:frontend/screen/sign_up.dart';
import '../apis/user_api.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  getLogin(String email, pass) async {
    login(email, pass);
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LandingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10.0),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'ادخل اسم المستخدم '),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'فضلاً ادخل اسم المستخدم';
                  }
                  // You can add more validation for email format if needed
                  return null;
                },
              ),
            ),
            const SizedBox(height: 10.0),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _passwordController,
                decoration:
                    const InputDecoration(labelText: 'ادخل كلمة المرور'),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'فضلاً ادخل كلمة المرور';
                  }
                  // You can add more validation for password strength if needed
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Form is valid, proceed with signup logic
                  // You can implement signup logic here
                  // For now, let's just print the form data
                  print('Email: ${_emailController.text}');
                  print('Password: ${_passwordController.text}');
                  print(getLogin(
                      _emailController.text, _passwordController.text));
                  // You might want to navigate to another screen after successful signup
                }
              },
              child: const Text('سجل دخولك'),
            ),
            const SizedBox(
              height: 50,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: " ليس لديك حساب؟",
                style: const TextStyle(color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: ' إنشاء حساب',
                    style: const TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Navigate to the sign-up screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
