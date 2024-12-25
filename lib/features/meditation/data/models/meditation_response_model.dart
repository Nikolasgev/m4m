import 'dart:io';

class MeditationResponseModel {
  final String text;
  final File audioFile;

  MeditationResponseModel({required this.text, required this.audioFile});

  factory MeditationResponseModel.fromJson(Map<String, dynamic> json, File audioFile) {
    return MeditationResponseModel(
      text: json['meditationText'] as String,
      audioFile: audioFile,
    );
  }
}