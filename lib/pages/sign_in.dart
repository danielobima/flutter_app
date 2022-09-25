import 'package:flutter/material.dart';
import 'package:flutter_app/providers/data.dart';
import 'package:flutter_app/utilities/colors.dart';
import 'package:flutter_app/utilities/toaster.dart';
import 'package:flutterfire_ui/auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> with Toaster{
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fToast.init(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AuthFlowBuilder<EmailFlowController>(
            listener: (oldState, state, controller) {
              if (state is SignedIn) {
                userID = state.user?.uid;
                Navigator.of(context).pushReplacementNamed('/');
              }
              else if(state is AuthFailed){
                showToast('Wrong email or password');
              }
            },
            builder: (context, state, controller, _){

              if (state is SigningIn) {
                return const Center(child: CircularProgressIndicator());
              }
              else{
                return SignInForm(emailController: emailController, passwordController: passwordController, controller: controller);
              }
            },
          ),
        ),
      ),
    );
  }
}


class SignInForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final EmailFlowController controller;

  const SignInForm({Key? key, required this.emailController, required this.passwordController, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.login_outlined,
          color: Color(mayaBlue),
          size: 70,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Sign in',
              style: TextStyle(
                  color: Color(prussianBlue),
                  fontSize: 42,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(
              labelText: 'Email',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(prussianBlue)),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          style: const TextStyle(color: Color(prussianBlue)),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
              labelText: 'Password',
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(prussianBlue)),
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          style: const TextStyle(color: Color(prussianBlue)),
          obscureText: true,
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            child: const Text('SIGN IN'),
            onPressed: () {
              controller.setEmailAndPassword(
                emailController.text,
                passwordController.text,
              );
            },
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16.0),
                shape: const RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(20))))),
        const SizedBox(
          height: 10,
        ),
        // OutlinedButton(
        //     onPressed: () {},
        //     child: const Text('CREATE A NEW ACCOUNT'),
        //     style: OutlinedButton.styleFrom(
        //       side: const BorderSide(color: Color(prussianBlue)),
        //       padding: const EdgeInsets.all(16.0),
        //       shape: const RoundedRectangleBorder(
        //         borderRadius: BorderRadius.all(Radius.circular(20)),
        //         side: BorderSide(color: Color(prussianBlue)),
        //       ),
        //     ))
      ],
    );
  }
}

