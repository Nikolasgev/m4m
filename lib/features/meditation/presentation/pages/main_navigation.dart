import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/domain/usecases/generate_meditation.dart';
import 'package:m4m_f/features/meditation/presentation/bloc/meditation_bloc.dart';
import 'package:m4m_f/features/auth/presentation/pages/auth_page.dart';
import 'package:m4m_f/features/meditation/presentation/pages/meditation_history_page.dart';
import 'package:m4m_f/features/meditation/presentation/pages/meditation_input_page.dart';
import 'package:m4m_f/features/meditation/presentation/pages/profile_page.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return BlocProvider(
            create: (_) => MeditationBloc(context.read<GenerateMeditation>()),
            child: const MainNavigationContent(),
          );
        } else {
          return const AuthPage();
        }
      },
    );
  }
}

class MainNavigationContent extends StatefulWidget {
  const MainNavigationContent({super.key});

  @override
  MainNavigationContentState createState() => MainNavigationContentState();
}

class MainNavigationContentState extends State<MainNavigationContent> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MeditationInputPage(),
    MeditationHistoryPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
