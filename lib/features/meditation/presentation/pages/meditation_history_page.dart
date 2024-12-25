import 'dart:io';

import 'package:flutter/material.dart';
import 'package:m4m_f/features/meditation/domain/entities/meditation_entity.dart';
import 'package:m4m_f/features/meditation/presentation/pages/meditation_player_page.dart';
import 'package:path_provider/path_provider.dart';

class MeditationHistoryPage extends StatefulWidget {
  const MeditationHistoryPage({super.key});

  @override
  MeditationHistoryPageState createState() {
    return MeditationHistoryPageState();
  }
}

class MeditationHistoryPageState extends State<MeditationHistoryPage> {
  late Future<List<File>> _meditationFiles;

  @override
  void initState() {
    super.initState();
    _meditationFiles = _loadMeditationFiles();
  }

  Future<List<File>> _loadMeditationFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    final files = directory.listSync().whereType<File>().toList();
    return files;
  }

  void _renameFile(File file) async {
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
            onPressed: () async {
              final directory = await getApplicationDocumentsDirectory();
              final newPath = '${directory.path}/${controller.text}';
              await file.rename(newPath);
              setState(() {
                _meditationFiles = _loadMeditationFiles();
              });
              Navigator.of(context).pop();
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }

  void _deleteFile(File file) async {
    await file.delete();
    setState(() {
      _meditationFiles = _loadMeditationFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('История медитаций')),
      body: FutureBuilder<List<File>>(
        future: _meditationFiles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Ошибка загрузки файлов.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет сохраненных медитаций.'));
          } else {
            final files = snapshot.data!;
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
                        onPressed: () => _renameFile(file),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteFile(file),
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
          }
        },
      ),
    );
  }
}
