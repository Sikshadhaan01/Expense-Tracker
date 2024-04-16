import 'package:expense_tracker/pages/homepage.dart';
import 'package:expense_tracker/services/user_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
              height: 150,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Log In",
                        softWrap: true,
                        // maxLines: 2,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color: Color(0xFFe53946)),
                      ),
                    ),
                    Image.asset("assets/family.jpeg")
                  ],
                ),
              )),
          Expanded(
            child: Container(
              // color: Colors.amber,
              decoration: const BoxDecoration(
                  color: Color(0xFF1e3557),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: LoginForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 10),
          Text(
            "Email",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // expands: true,
            controller: _emailController,
            style: Theme.of(context).textTheme.labelMedium,
            decoration: InputDecoration(
                errorStyle: Theme.of(context).textTheme.labelSmall,
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.email),
                suffixIconColor: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Text(
            "Password",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          TextFormField(
            style: Theme.of(context).textTheme.labelMedium,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            // expands: true,
            controller: _passwordController,
            decoration: InputDecoration(
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                errorStyle: Theme.of(context).textTheme.labelSmall,
                border: const OutlineInputBorder(),
                suffixIcon: const Icon(Icons.lock_open),
                suffixIconColor: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFe53946)),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                var jsonObj = {
                  "email": _emailController.text,
                  "pass": _passwordController.text,
                };
                var response = await UserService().login(jsonObj);
                print(response);
                if (response['message'] == 'Login Success') {
                  context.go('/');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Invalid Credential'),
                    ),
                  );
                }
                // Perform sign-up logic here
                // For example, send data to server
                // and navigate to another screen
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text('Login successful!'),
                //   ),
                // );
              }
            },
            child: const Text(
              'Log In',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "Don't have an account?",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 5,
                )),
                TextSpan(
                    text: "SignUp",
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.go('/signup')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
