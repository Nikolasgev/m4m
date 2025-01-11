import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/core/widgets/common_button.dart';
import 'package:m4m_f/core/widgets/common_text_field.dart';
import 'package:m4m_f/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:m4m_f/features/auth/presentation/pages/registration_page.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Добро пожаловать!',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            CommonTextField(
              controller: _emailController,
              labelText: 'Электронная почта',
            ),
            const SizedBox(
              height: 20,
            ),
            CommonTextField(
              controller: _passwordController,
              labelText: 'Пароль',
            ),
            const SizedBox(height: 60),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return CommonButton(
                    text: 'Войти',
                    onTap: () => context.read<AuthBloc>().add(
                          LoginEvent(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        ));
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegistrationPage(),
                  ),
                );
              },
              child: Text('Забыли пароль?',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
