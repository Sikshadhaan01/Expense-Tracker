import 'package:expense_tracker/services/user_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                        "Create an account",
                        softWrap: true,
                        // maxLines: 2,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 38,
                            color: Color(0xFFe53946)),
                      ),
                    ),
                    Image.asset("assets/front family.jpg")
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
                child: SignUpForm(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            "Full Name",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.labelMedium,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // expands: true,
              controller: _nameController,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  errorStyle: Theme.of(context).textTheme.labelSmall,
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.person),
                  suffixIconColor: Colors.white),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
            ),
          ),
          //const SizedBox(height: 10),
          Text(
            "Email",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Expanded(
            child: TextFormField(
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
          ),
          //const SizedBox(height: 10),
          Text(
            "Password",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Expanded(
            child: TextFormField(
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
          ),
          //const SizedBox(height: 10),
          Text(
            "Confirm Password",
            style: Theme.of(context).textTheme.labelMedium,
          ),
          Expanded(
            child: TextFormField(
              style: Theme.of(context).textTheme.labelMedium,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              // expands: true,
              controller: _confirmPasswordController,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  errorStyle: Theme.of(context).textTheme.labelSmall,
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.lock),
                  suffixIconColor: Colors.white),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm your password';
                }
                return null;
              },
            ),
          ),
          // const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_passwordController.text !=
                    _confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Password doesnt match'),
                    ),
                  );
                  return;
                }
                var jsonObj = {
                  "userName": _nameController.text,
                  "email": _emailController.text,
                  "pass": _passwordController.text
                };
                UserService().signup(jsonObj);
                // context.go('/');
                // Perform sign-up logic here
                // For example, send data to server
                // and navigate to another screen
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sign up successful!'),
                  ),
                );
              }
            },
            child: const Text('Sign Up'),
          ),
          const SizedBox(
            height: 15,
          ),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "already have an account",
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
                    text: "Login",
                    style: const TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.go('/login')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
