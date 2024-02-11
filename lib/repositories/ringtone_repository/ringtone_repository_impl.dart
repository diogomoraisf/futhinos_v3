import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/repositories/ringtone_repository/ringtone_repository.dart';
import 'package:path_provider/path_provider.dart';

class RingtoneRepositoryImpl implements RingtoneRepository {
  var platform = const MethodChannel("com.futhinov2.app/kotlin");
  late Directory applicationFileDirectory;

  @override
  Future<void> setRingtone(String path) async {
    try {
      var data = <String, String>{'path': path};
      await platform.invokeMethod("setRingtone", data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteAFile(path) async {
    try {
      var data = <String, String>{"fileToDelete": path};
      await platform.invokeMethod("deleteFile", data);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> duplicateFile(String expected) async {
    final String ext = getFileExt(expected);
    String result = expected;
    int iterations = 0;
    while (true) {
      if (await File(result).exists()) {
        iterations += 1;
        result = result.replaceAll(ext, "");
        result += "($iterations)";
        result += ext;
      } else {
        return result;
      }
    }
  }

  @override
  String getFileExt(String file) {
    String trim = file.replaceRange(0, file.length - 5, "");
    if (trim.contains(".")) {
      String ext = trim.replaceRange(0, trim.indexOf("."), "");
      return ext;
    } else {
      throw Exception("No Extension found in $file");
    }
  }

  @override
  Future<void> addRingtone({required pathOfFile, required String title}) async {
    applicationFileDirectory = await getApplicationDocumentsDirectory();
    const String ext = ".mp3"; //getFileExt(pathOfFile);
    final String outputFile =
        "${applicationFileDirectory.path}/$title$ext".replaceAll(" ", "-");
    final String finalFile = await duplicateFile(
        "/storage/emulated/0/Music/$title$ext".replaceAll(" ", "-"));
    await File(pathOfFile).copy("${applicationFileDirectory.path}/raw$ext");
    try {
      await File(outputFile).copy(finalFile);
      await broadcastFileChange(finalFile);
      await setRingtone(finalFile);
      await File(outputFile).delete();
    } catch (e, s) {
      log('erro ao adicionar ringtone', error: e, stackTrace: s);
      throw RespositoryExceptions(
          message:
              'Oopss.. que gol contra.. tivemos um problema aqui. Tente novamente mais tarde.');
    }
  }

  @override
  broadcastFileChange(String path) async {
    try {
      var data = <String, String>{"filePath": path};
      await platform.invokeMethod("broadcastFileChange", data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
