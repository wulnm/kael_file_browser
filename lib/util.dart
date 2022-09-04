import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as Path;

class Util {
  static String moveFile(String src, String dst) {
    String msg = "";
    if (src.isEmpty || dst.isEmpty) {
      return msg;
    }
    try {
      File dstTmp = File(dst);
      if (!dstTmp.existsSync()) {
        dstTmp.parent.createSync(recursive: true);
      }
      File(src).renameSync(dst);
    } catch (e) {
      msg = e.toString();
    }
    return msg;
    // return Process.runSync('mv', [src, dst]).stderr.toString();
  }

  static String getUserDirectory() {
    String home = "/";
    Map<String, String> envVars = Platform.environment;
    if (Platform.isMacOS) {
      home = envVars['HOME'] ?? home;
    } else if (Platform.isLinux) {
      home = envVars['HOME'] ?? home;
    } else if (Platform.isWindows) {
      home = envVars['UserProfile'] ?? home;
    }
    return home;
  }

  static bool isVideo(String filename) {
    List exts = List.of(<String>[
      '.mp4',
      '.m4v',
      '.mov',
      '.wmv',
      '.avi',
      '.avchd',
      '.flv,',
      '.f4v,',
      '.swf',
      '.mkv'
    ]);
    return exts.contains(Path.extension(filename.toLowerCase()));
  }

  static bool isImage(String filename) {
    List exts = List.of(<String>['.jpg', '.jpeg', '.png', '.gif']);
    return exts.contains(Path.extension(filename.toLowerCase()));
  }

  static Future<void> showInfoDialog(
      BuildContext context, String title, String content) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: content.split("\n").map((e) => Text(e)).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
