import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m4m_f/core/widgets/common_button.dart';
import 'package:m4m_f/features/auth/presentation/pages/auth_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Profile Page Content'),
          CommonButton(
            text: 'Выйти',
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AuthPage(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
