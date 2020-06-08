import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

abstract class FileHelper {
  Future<String> getApplicationDocumentsDirectoryPath();

  Future<File> getFileFromUrl(String url);

  Future<MultipartFile> convertFileToMultipartFile(File file);

  String generateMd5(Uint8List data);
}

@LazySingleton(as: FileHelper)
class FileHelperImpl implements FileHelper {
  @override
  Future<String> getApplicationDocumentsDirectoryPath() async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  @override
  Future<File> getFileFromUrl(String url) async {
    final dir = await getApplicationDocumentsDirectoryPath();
    final file = File('$dir/${basename(url)}');

    return file;
  }

  @override
  Future<MultipartFile> convertFileToMultipartFile(File file) async {
    final fileBaseName = basename(file.path);
    final mimeType = lookupMimeType(fileBaseName);
    final contentType = MediaType.parse(mimeType);

    return MultipartFile.fromFileSync(
      file.path,
      filename: fileBaseName,
      contentType: contentType,
    );
  }

  @override
  String generateMd5(Uint8List data) {
    List<int> bytes = data.map((eachInt) => eachInt.toInt()).toList();
    var md5 = crypto.md5;
    var digest = md5.convert(bytes);
    return base64.encode(digest.bytes).toString();
  }
}