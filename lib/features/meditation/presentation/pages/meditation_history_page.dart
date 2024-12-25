import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:m4m_f/features/meditation/domain/entities/meditation_entity.dart';
import 'package:m4m_f/features/meditation/presentation/bloc/meditation_history_bloc.dart';
import 'package:m4m_f/features/meditation/presentation/pages/meditation_player_page.dart';

class MeditationHistoryPage extends StatelessWidget {
  const MeditationHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('История медитаций')),
      body: BlocBuilder<MeditationHistoryBloc, MeditationHistoryState>(
        builder: (context, state) {
          if (state is MeditationHistoryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MeditationHistoryError) {
            return Center(child: Text(state.message));
          } else if (state is MeditationHistoryLoaded) {
            final files = state.history;
            if (files.isEmpty) {
              return const Center(child: Text('Нет сохраненных медитаций.'));
            }
            return ListView.builder(
              itemCount: files.length,
              itemBuilder: (context, index) {
                final file = files[index];
                return ListTile(
                  title: Text(file.uri.pathSegments.last),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showRenameDialog(context, file),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteFile(context, file),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MeditationPlayerPage(
                          meditation: MeditationEntity(
                            text: 'Проигрывание сохраненной медитации',
                            audioFile: file,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Неизвестное состояние.'));
          }
        },
      ),
    );
  }

  void _showRenameDialog(BuildContext context, File file) async {
    final TextEditingController controller =
        TextEditingController(text: file.uri.pathSegments.last);
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Переименовать файл'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Новое имя файла'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              context.read<MeditationHistoryBloc>().add(
                    RenameMeditation(file, controller.text),
                  );
              Navigator.of(context).pop();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _deleteFile(BuildContext context, File file) {
    context.read<MeditationHistoryBloc>().add(DeleteMeditation(file));
  }
}
