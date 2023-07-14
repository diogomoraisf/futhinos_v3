import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class DownloadHinoRepository {
  Future<String?> findLocalPath();
  Future<DownloadTaskStatus?> downloadHino(String urlHino, String fileName);
  Future<PermissionStatus> checkStorageAndPhotodPermission();
}
