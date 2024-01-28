import 'dart:async';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

extension HiveExtentionInterface on HiveInterface {
  /// Get a name list of existing hive boxes
  FutureOr<List<String>> getNamesOfBoxes() async {
    final appDir = await getApplicationDocumentsDirectory();
    var files = appDir.listSync();
    var _list = <String>[];

    files.forEach((file) {
      if (file.statSync().type == FileSystemEntityType.file &&
          p.extension(file.path).toLowerCase() == '.hive') {
        _list.add(p.basenameWithoutExtension(file.path));
      }
    });
    return _list;
  }

  /* ---------------------------------------------------------------------------- */
  /// Delete existing boxes from disk
  deleteBoxes() async {
    try {
      final _boxes = await this.getNamesOfBoxes();
      // Exclude the 'user_profile' box because it contains the token and other user details
      //Exclude the 'appVersion'box because it Kept the version information
      final boxToExclude = ['user_profile', "app_version"];
      if (_boxes.isNotEmpty) {
        _boxes.forEach((name) {
          if (name != boxToExclude[0] && name != boxToExclude[1]) {
            this.deleteBoxFromDisk(name);
            print("clear boc -----$name");
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }
}
