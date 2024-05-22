import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/const.dart';
import 'package:frontend/screen/landing_screen.dart';
import 'package:frontend/screen/sign_up.dart';
import '../apis/user_api.dart';
import 'package:another_flushbar/flushbar.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('تسجيل الدخول'),
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
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  getLogin(String username, String password) async {
    final result = await login(username, password);
    if (result['user'] != null) {
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ),
      );
    } else {
      setState(() {
        _showErrorFlushbar(context, result['error']);
      });
    }
  }

  void _showErrorFlushbar(BuildContext context, String message) {
    Flushbar(
      messageText: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: error,
      duration: const Duration(seconds: 4),
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Directionality(
              textDirection: TextDirection.rtl,
              child: Text(
                "مرحباً بعودتك 👋 ",
                style: TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 15),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المستخدم',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                textDirection: TextDirection.ltr, // Ensure LTR for input text
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'فضلاً ادخل اسم المستخدم';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 35),
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'كلمة المرور',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
                obscureText: true,
                textDirection: TextDirection.ltr, // Ensure LTR for input text
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'فضلاً ادخل كلمة المرور';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  getLogin(_usernameController.text, _passwordController.text);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: primary1),
              child: const Text(
                'سجل دخولك',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 20,
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
            ),
          ],
        ),
      ),
    );
  }
}
