import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:m4m_f/core/widgets/common_buttom.dart';
import 'package:m4m_f/features/auth/presentation/pages/registration_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                'assets/svg/welcome.svg',
              ),
            ),
            const SizedBox(height: 120),
            CommonButton(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              text: 'Создать новый аккаунт',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationPage(),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Уже есть аккаунт?',
                    style: Theme.of(context).textTheme.titleSmall),
                TextButton(
                  onPressed: () {},
                  child: Text('Войти',
                      style: Theme.of(context).textTheme.titleMedium),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
