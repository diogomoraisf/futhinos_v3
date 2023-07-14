import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:futhinos_v2/core/exceptions/respository_exceptions.dart';
import 'package:futhinos_v2/repositories/download_hino/download_hino_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadHinoRepositoryImpl implements DownloadHinoRepository {
  @override
  Future<String?> findLocalPath() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return "/sdcard/download/";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return '${directory.path}${Platform.pathSeparator}Download';
    }
  }

  @override
  Future<PermissionStatus> checkStorageAndPhotodPermission() async {
    await Permission.storage.request();
    await Permission.photos.request();

    return await Permission.storage.status;
  }

  @override
  Future<DownloadTaskStatus> downloadHino(
      String urlHino, String fileName) async {
    DownloadTaskStatus statusTask = DownloadTaskStatus.undefined;
    var statusPermission = await checkStorageAndPhotodPermission().onError(
        (error, stackTrace) => throw RespositoryExceptions(
            message:
                'Oops.. algum erro inesperado aqui. Tente novamente mais tarde.'));
    if (statusPermission.isGranted) {
      var localPath = (await findLocalPath().onError((error, stackTrace) =>
          throw RespositoryExceptions(
              message:
                  'Oops.. algum erro inesperado aqui. Tente novamente mais tarde.')))!;
      final savedDir = Directory(localPath);
      await savedDir.create(recursive: true).then((value) async {
        String? taskid = await FlutterDownloader.enqueue(
                url: urlHino,
                fileName: fileName,
                savedDir: localPath,
                showNotification: true,
                openFileFromNotification: true,
                requiresStorageNotLow: false)
            .onError((error, stackTrace) => throw RespositoryExceptions(
                message:
                    'Oops.. algum erro inesperado aqui. Tente novamente mais tarde.'));
        List<DownloadTask>? listTasks = await FlutterDownloader.loadTasks()
            .onError((error, stackTrace) => throw RespositoryExceptions(
                message:
                    'Oops.. algum erro inesperado aqui. Tente novamente mais tarde.'));
        if (listTasks != null) {
          for (var element in listTasks) {
            statusTask = element.status;
            if (statusTask == DownloadTaskStatus.complete ||
                statusTask == DownloadTaskStatus.running) {
              return statusTask;
            } else {
              throw RespositoryExceptions(
                  message:
                      'Oops.. algum erro inesperado aqui. Tente novamente mais tarde.');
            }
          }
        } else {
          throw RespositoryExceptions(
              message:
                  'Oops.. algum erro inesperado aqui. Tente novamente mais tarde.');
        }
      }).onError((error, stackTrace) => throw RespositoryExceptions(
          message:
              'Oops.. algum erro inesperado aqui. Tente novamente mais tarde.'));
    } else {
      throw RespositoryExceptions(
          message: 'Acesso negado. Permita acesso ao armazenamento interno.');
    }
    return statusTask;
  }
}
