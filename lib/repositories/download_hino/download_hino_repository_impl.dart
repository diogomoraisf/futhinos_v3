import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:futhinos_v2/repositories/download_hino/download_hino_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadHinoRepositoryImpl implements DownloadHinoRepository {
  @override
  Future<PermissionStatus> checkStorageAndPhotodPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt <= 32) {
        await Permission.storage.request();
        return await Permission.storage.status;
      } else {
        await Permission.photos.request();
        return await Permission.photos.status;
      }
    } else {
      await Permission.storage.request();
      await Permission.photos.request();
      return await Permission.storage.status;
    }
  }

  @override
  Future<PermissionStatus> prepareDownload() async {
    var statusPermission = await checkStorageAndPhotodPermission();
    return statusPermission;
  }
}
