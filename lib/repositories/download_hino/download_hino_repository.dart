import 'package:permission_handler/permission_handler.dart';

abstract class DownloadHinoRepository {
  Future<PermissionStatus> checkStorageAndPhotodPermission();
  Future<PermissionStatus> prepareDownload();
}
