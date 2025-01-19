import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/checkin_bloc.dart';

class CheckinHistoryPage extends StatelessWidget {
  const CheckinHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('История чек-инов')),
      body: BlocBuilder<CheckinBloc, CheckinState>(
        builder: (context, state) {
          if (state is CheckinsLoaded) {
            final checkins = state.checkins;
            return ListView.builder(
              itemCount: checkins.length,
              itemBuilder: (context, index) {
                final checkin = checkins[index];
                return ListTile(
                  title: Text('${checkin.date}'),
                  subtitle: Text(
                      'Настроение: ${checkin.mood}, Энергия: ${checkin.energy}, Стресс: ${checkin.stress}'),
                );
              },
            );
          } else if (state is CheckinError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
