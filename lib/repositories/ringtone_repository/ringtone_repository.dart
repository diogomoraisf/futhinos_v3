abstract class RingtoneRepository {
  Future<void> addRingtone({required pathOfFile, required String title});
  Future<void> setRingtone(String path);
  Future<void> deleteAFile(path);
  Future<String> duplicateFile(String expected);
  String getFileExt(String file);
  broadcastFileChange(String path);
}
