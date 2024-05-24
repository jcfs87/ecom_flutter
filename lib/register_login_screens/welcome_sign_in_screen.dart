import 'package:ecom_app/methods/generic_methods.dart';
import 'package:ecom_app/register_login_screens/login_user_form.dart';
import 'package:ecom_app/register_login_screens/welcome_sign_up_screen.dart';
import 'package:ecom_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WelcomeSignInScreen extends StatelessWidget {
  const WelcomeSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
            // const SizedBox(
            //   height: 20,
            // ),
            Text(
              '¿Cómo quieres\niniciar sesión?',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              color: Colors.lightBlue,
              text: 'Continuar con el email',
              onTapButton: () {
                navigator(context, const LoginUserForm());
              },
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
              color: Colors.indigo,
              text: 'Continuar con google',
              onTapButton: () {
                navigator(context, const LoginUserForm());
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '¿Todavía no tienes una cuenta?',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                    textStyle: const TextStyle(
                  fontSize: 16,
                )),
                onPressed: () {
                  navigator(context, const WelcomeSignUpScreen());
                },
                child: const Text('Registrarse'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
