import 'package:flutter/material.dart';
import 'package:ecom_app/widgets/custom_button.dart';
import 'package:ecom_app/register_login_screens/create_user_form.dart';
import 'package:ecom_app/register_login_screens/welcome_sign_in_screen.dart';
import 'package:ecom_app/methods/generic_methods.dart';

class WelcomeSignUpScreen extends StatelessWidget {
  const WelcomeSignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              '¿Cómo quieres registrarte?',
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
                  navigator(context, const CreateUserForm());
                }),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
                color: Colors.indigo,
                text: 'Continuar con google',
                onTapButton: () {
                  navigator(context, const CreateUserForm());
                }),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '¿Ya tienes una cuenta?',
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
                  navigator(context, const WelcomeSignInScreen());
                },
                child: const Text(
                  'Iniciar sesión',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
