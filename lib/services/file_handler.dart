import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:real_estate_app/models/property.dart';


class FileHandler {
  static const String _fileName = 'properties.txt';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> _localFile() async {
    final path = join(await _localPath, _fileName);
    return File(path);
  }

  Future<void> writeToFile(String content) async {
    try {
      final file = await _localFile();
      if (!await file.exists()) {
        await file.create();
      }
      await file.writeAsString(content);
    } catch (e) {
      if (kDebugMode) {
        print('Error writing to file: $e');
      }
    }
  }

  Future<String> readFromFile() async {
    try {
      final file = await _localFile();
      if (!await file.exists()) {
        return '';
      }
      return await file.readAsString();
    } catch (e) {
      if (kDebugMode) {
        print('Error reading from file: $e');
      }
      return '';
    }
  }

  Future<List<Property>> readProperties() async {
    final content = await readFromFile();
    return content.split('\n').map((line) => Property.fromCSV(line)).toList();
  }

  Future<void> writeProperties(List<Property> properties) async {
    final content = properties.map((p) => p.toCSV()).join('\n');
    await writeToFile(content);
  }

  Future<void> deleteProperty(String address) async {
    final properties = await readProperties();
    final updatedProperties = properties.where((p) => p.address != address).toList();
    await writeProperties(updatedProperties);
  }
}
