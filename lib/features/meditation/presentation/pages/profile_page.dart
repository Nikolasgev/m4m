import 'package:flutter/material.dart';
import 'package:m4m_f/features/meditation/presentation/pages/registration_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile Page Content'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegistrationPage(),
                ),
              );
            },
            child: const Text('Регистрация'),
          ),
        ],
      ),
    );
  }
}
